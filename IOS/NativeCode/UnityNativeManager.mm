//
//  UnityNativeManager.mm
//  Unity-iPhone
//
//  Created by Mike on 8/7/10.
//  Copyright 2010 Prime31 Studios. All rights reserved.
//

#import "UnityNativeManager.h"
#include <CoreGraphics/CoreGraphics.h> // Be sure to include CoreGraphics framework!

#import "SplashScreen.h"

void UnityPause( bool pause );


@implementation UnityNativeManager

@synthesize navigationControler = _navigationControler, animationType = _animationType,
			animationSubtype = _animationSubtype, animationTimingFunction = _animationTimingFunction,
			animationDuration = _animationDuration;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

+ (UnityNativeManager*)sharedManager
{
	static UnityNativeManager *sharedManager = nil;
	
	if( !sharedManager )
		sharedManager = [[UnityNativeManager alloc] init];
	
	return sharedManager;
}


- (id)init
{
	if( ( self = [super init] ) )
	{
		// Default to fade animation and reasonable duration
		self.animationType = kCATransitionFade;
		self.animationDuration = 0.5;
		self.animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Private

- (NSString*)oppositeAnimationSubtype
{
	if( _animationSubtype == kCATransitionFromRight )
		return kCATransitionFromLeft;
	
	if( _animationSubtype == kCATransitionFromLeft )
		return kCATransitionFromRight;
	
	if( _animationSubtype == kCATransitionFromTop )
		return kCATransitionFromBottom;
	
	if( _animationSubtype == kCATransitionFromBottom )
		return kCATransitionFromTop;
	
	return nil;
}


- (void)animationDidStop:(CAAnimation*)theAnimation finished:(BOOL)flag
{
	UnityPause( false );
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Public

- (void)setAnimationType:(NSString*)animationType subtype:(NSString*)animationSubtype
{
	self.animationType = animationType;
	self.animationSubtype = animationSubtype;
}


- (void)showViewControllerWithName:(NSString*)name
{
    NSLog(@"showViewControllerWithName: %@", name);
    NSArray *tempArray = [name componentsSeparatedByString:@"_"];
    [[NSUserDefaults standardUserDefaults] setObject:[tempArray objectAtIndex:1] forKey:[tempArray objectAtIndex:0]];

    if (_navigationControler) {
        // Pause Unity
        UnityPause( true );
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        [_navigationControler.view setBackgroundColor:[UIColor blackColor]];
        [_navigationControler.view setFrame:window.frame];
        
        // Set up the fade-in animation
        CATransition *animation = [CATransition animation];
        [animation setType:_animationType];
        [animation setSubtype:_animationSubtype];
        [animation setDuration:_animationDuration];
        [animation setTimingFunction:_animationTimingFunction];
        [window.layer addAnimation:animation forKey:@"layerAnimation"];
        
        
        
        [[SplashScreen sharedInstance] viewDidLoad];
        return;
    }
    
	// Grab the controller from the given class name. Early out if we dont have it available
	Class controllerClass = NSClassFromString( [tempArray objectAtIndex:0] );
	if( !controllerClass )
		return;
	
	// Pause Unity
	UnityPause( true );
	
	// Instantiate the controller and wrap it in a UINavigationController
	UIViewController *controller = [[SplashScreen sharedInstance] initWithNibName:nil bundle:nil];
	_navigationControler = [[UINavigationController alloc] initWithRootViewController:controller];
	_navigationControler.navigationBarHidden = YES;
	_navigationControler.view.backgroundColor = [UIColor blackColor];
	
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	
	// If we are landscape, manually rotate our view //bug in iOS6
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6) {
        if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft )
            controller.view.transform = CGAffineTransformMakeRotation( -1.5708 );
        else if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight )
            controller.view.transform = CGAffineTransformMakeRotation( 1.5708 );
    }
	
	// Set up the fade-in animation
    CATransition *animation = [CATransition animation];
    [animation setType:_animationType];
	[animation setSubtype:_animationSubtype];
	[animation setDuration:_animationDuration];
	[animation setTimingFunction:_animationTimingFunction];
    [window.layer addAnimation:animation forKey:@"layerAnimation"];
	
	[window addSubview:_navigationControler.view];
	[controller release];
}

- (void)hideViewControllerAndRestartUnity
{
	// Set up the fade-out animation
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CATransition *animation = [CATransition animation];
    [animation setType:_animationType];
	[animation setDuration:_animationDuration];
	[animation setTimingFunction:_animationTimingFunction];
	[animation setDelegate:self];
	
	// Reverse the animationSubtype if we have one
	if( _animationSubtype )
		[animation setSubtype:[self oppositeAnimationSubtype]];
	
    [window.layer addAnimation:animation forKey:@"layerAnimation"];
	
	_navigationControler.viewControllers = nil;
	[_navigationControler.view removeFromSuperview];
	
	[_navigationControler release];
	_navigationControler = nil;
}

- (void)hideViewController
{
	// Set up the fade-out animation
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CATransition *animation = [CATransition animation];
    [animation setType:_animationType];
	[animation setDuration:_animationDuration];
	[animation setTimingFunction:_animationTimingFunction];
	[animation setDelegate:self];
	
	// Reverse the animationSubtype if we have one
	if( _animationSubtype )
		[animation setSubtype:[self oppositeAnimationSubtype]];
	
    [window.layer addAnimation:animation forKey:@"layerAnimation"];
	
	[_navigationControler.view setBackgroundColor:[UIColor clearColor]];
    [_navigationControler.view setFrame:CGRectMake(220, 0, 100, 100)];
}

- (void)pauseUnity:(BOOL)shouldPause
{
	if( shouldPause )
		UnityPause( true );
	else
		UnityPause( false );
}


@end
