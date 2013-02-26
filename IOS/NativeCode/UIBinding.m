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
//    if ([SaveFile sharedFile].highestCombo < count) {
//        [SaveFile sharedFile].highestCombo = count;
//        [SaveFile saveData];
//    }

    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"highestCombo"] < count) {
        [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"highestCombo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [[SplashScreen sharedInstance] setCombo:count];
}

void _deactivateUI()
{
    NSLog(@"_deactivate");
	[[UnityNativeManager sharedManager] hideViewControllerAndRestartUnity];
}

void _setCake( int cake)
{
//    [SaveFile sharedFile].totalCakes += cake;
    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"totalCakes"]+cake forKey:@"totalCakes"];
}

void _setCoin( int coin)
{
//    [SaveFile sharedFile].totalCoins += coin;
    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"totalCoins"]+coin forKey:@"totalCoins"];
}

void _setTotalTimePlayed ( float sec)
{
//    [SaveFile sharedFile].totalTimePlayed += sec;
    [[NSUserDefaults standardUserDefaults] setFloat:[[NSUserDefaults standardUserDefaults] floatForKey:@"totalTimePlayed"]+sec forKey:@"totalTimePlayed"];
}

void _setStageCleared ( const char *stage)
{
    NSString *tempStage = [NSString stringWithUTF8String:stage];
//    [[SaveFile sharedFile].listStages setObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"cleared", nil] forKey:tempStage];
    
    [[NSUserDefaults standardUserDefaults] setObject:@{tempStage : [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"cleared", nil]} forKey:@"listStages"];
}