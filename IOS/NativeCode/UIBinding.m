//
//  UIBinding.m
//  Unity-iPhone

#import "UIBinding.h"
#import "UnityNativeManager.h"


void _activateUIWithController( const char *controllerName )
{
	NSString *className = [NSString stringWithUTF8String:controllerName];
	
	[[UnityNativeManager sharedManager] showViewControllerWithName:className];
}

void _activateUIWithControllerWith( const char *controllerName , const char *xxx)
{
	NSString *className = [NSString stringWithUTF8String:controllerName];
	
	[[UnityNativeManager sharedManager] showViewControllerWithName:className ];
}

void _deactivateUI()
{
    NSLog(@"_deactivate");
	[[UnityNativeManager sharedManager] hideViewControllerAndRestartUnity];
}