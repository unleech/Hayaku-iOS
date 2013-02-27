//
//  TestViewController.m
//  delete_me
//
//  Created by Mike on 8/7/10.
//  Copyright 2010 Prime31 Studios. All rights reserved.
//

#import "TestViewController.h"
#import "UnityNativeManager.h"


void UnityPause( bool pause );


@implementation TestViewController


- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    if( ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) )
	{
        NSLog(@"init");
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (IBAction)onTouchTest
{
//	[[UnityNativeManager sharedManager] hideViewControllerAndRestartUnity];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onTouchOther
{
//	[[UnityNativeManager sharedManager] pauseUnity:NO];
//	UnitySendMessage( "UnityGameController", "loadLevelAdditiveAsync", [@"PartialScene" UTF8String] );
}


- (void)dealloc
{
    [super dealloc];
}


@end
