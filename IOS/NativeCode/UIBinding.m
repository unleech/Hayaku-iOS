//
//  UIBinding.m
//  Unity-iPhone

#import "UIBinding.h"
#import "UnityNativeManager.h"
#import "SplashScreen.h"
#import "SaveFile.h"

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

void _setCake( int cake)
{
    [SaveFile sharedFile].totalCakes += cake;
}

void _setCoin( int coin)
{
    [SaveFile sharedFile].totalCoins += coin;
}

void _setTotalTimePlayed ( float sec)
{
    [SaveFile sharedFile].totalTimePlayed += sec;
}

void _setStageCleared ( const char *stage)
{
    NSString *tempStage = [NSString stringWithUTF8String:stage];
    [[SaveFile sharedFile].listStages setObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"cleared", nil] forKey:tempStage];
}