//
//  FacebookManager.h
//  FacebookTest
//
//  Created by martin magalong on 11/30/12.
//  Copyright (c) 2012 ripplewave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookVeiwController.h"

@interface FacebookManager : NSObject<FBviewControllerProtocol>{
    NSMutableDictionary *_tempParam;
    FacebookVeiwController *_controller;
    UINavigationController *_navController;
}
@property (strong, nonatomic) FBSession *session;
+ (FacebookManager *)sharedInstance;
- (void)login:(void(^)(BOOL))a;
- (void)logout;
- (BOOL)isAuthenticated;
//- (void)publishStory:(NSDictionary *)param;
- (void)getNearBy:(NSDictionary *)param callback:(void(^)(id))callback;
@end

