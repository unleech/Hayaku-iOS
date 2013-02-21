//
//  SplashScreen.h
//  Unity-iPhone
//
//  Created by Jan Michael on 2/14/13.
//
//

#import <UIKit/UIKit.h>
#import "FacebookManager.h"

@interface SplashScreen : UIViewController
{
    FacebookManager* _fbManager;
    int counter;
    int counterHP;
    int counterMP;
}

+ (id) sharedInstance;

- (void)setHP:(int) count;
- (void)setMP:(int) count;
- (void)setCombo:(int) count;

@end
