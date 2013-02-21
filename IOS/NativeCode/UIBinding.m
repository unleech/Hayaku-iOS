//
//  UIBinding.m
//  Unity-iPhone

#import "UIBinding.h"
#import "UnityNativeManager.h"
#import "SplashScreen.h"

void _activateUIWithController( const char *controllerName )
{
	NSString *className = [NSString stringWithUTF8String:controllerName];
	
	[[UnityNativeManager sharedManager] showViewControllerWithName:className];
}

void _setHP( int count)
{
    [[SplashScreen sharedInstance] setHP:count];
}

void _setMP( int count)
{
    [[SplashScreen sharedInstance] setMP:count];
}

void _setCombo( int count)
{
    [[SplashScreen sharedInstance] setCombo:count];
}

void _deactivateUI()
{
    NSLog(@"_deactivate");
	[[UnityNativeManager sharedManager] hideViewControllerAndRestartUnity];
}