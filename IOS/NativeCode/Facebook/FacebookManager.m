//
//  FacebookManager.m
//  FacebookTest
//
//  Created by martin magalong on 11/30/12.
//  Copyright (c) 2012 ripplewave. All rights reserved.
//

#import "FacebookManager.h"
#import "CustomAlert.h"
#import "Flurry.h"
#import "GAI.h"

@implementation FacebookManager


static FacebookManager *_facebookManager = nil;

+(FacebookManager *)sharedInstance{
    if (_facebookManager == nil) {
        _facebookManager = [[self alloc]init];
    }
    return _facebookManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self showDebugLog];
        NSArray *array = [[NSArray alloc]initWithObjects:@"status_update",@"publish_actions",@"publish_stream",/*@"read_stream",@"publish_checkins",*/ nil];
        self.session = [[FBSession alloc] initWithPermissions:array];
        //        request = [FBRequest requestForGraphPath:@"125165664210637"];
    }
    return self;
}

#pragma mark -
#pragma mark Actions
#pragma mark Post Story
- (void)postStory:(NSDictionary *)param
{
    [self showSpinner];
    [param setValue:_session.accessToken forKey:@"access_token"];
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:param
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:@"Failed!"];
         } else {
            [self _didCancel];
             alertText = [NSString stringWithFormat:@"Success!"];
         }
         [self showAlertWithText:alertText];
     }];
}

- (void)publishStory:(NSDictionary *)param{
    _tempParam = [[NSMutableDictionary alloc]initWithDictionary:param];
    if(![self.session isOpen]){
        [self login:^(BOOL success){
            [self publishStory:_tempParam];
        }];
    }
    else{
        if ([self.session.permissions
             indexOfObject:@"publish_actions"] == NSNotFound) {
            // No permissions found in session, ask for it
            [self.session reauthorizeWithPublishPermissions: [NSArray arrayWithObject:@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends
                                          completionHandler:^(FBSession *session, NSError *error) {
                                              if (!error) {
                                                  // If permissions granted, publish the story
                                                  [self postStory:_tempParam];
                                              }
                                          }];
        } else {
            // If permissions present, publish the story
            [self postStory:_tempParam];
        }
    }
}

#pragma mark Nearby Places
- (void)getNearBy:(NSDictionary *)param callback:(void(^)(id))callback{
    [self showSpinner];
    [param setValue:_session.accessToken forKey:@"access_token"];
    [FBRequestConnection
     startWithGraphPath:@"search"
     parameters:param
     HTTPMethod:@"GET"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:@"Failed!"];
         } else {
             alertText = [NSString stringWithFormat:@"Success!"];
         }
         [self showAlertWithText:alertText];
         callback(result);
     }];
    
    //    FBRequest *request = [FBRequest requestForPlacesSearchAtCoordinate:location radiusInMeters:500 resultsLimit:20 searchText:@""];
    //    [FBRequestConnection startForPostWithGraphPath:[request graphPath] graphObject:[request graphObject]completionHandler:nil];
}
#pragma mark others
- (void)showAlertWithText:(NSString *)alertText{
    // Show the result in an alert
    [[[CustomAlert alloc] initWithTitle:@"Result"
                                message:alertText
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil]
     show];
}

- (void)showDebugLog{
    if (NO/*DEBUG*/) {
        [FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorFBRequests, FBLoggingBehaviorFBURLConnections, nil]];
    }
}

#pragma mark -
#pragma mark - ViewController
- (void)showViewController{
    [Flurry logEvent:@"Facebook_show"];
    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Faceook_show" withValue:nil];
    if(!_controller){
        _controller = [[FacebookVeiwController alloc]init];
        _controller.delegate = self;
    }
    _navController = [[UINavigationController alloc]initWithRootViewController:_controller];
    _navController.navigationBar.barStyle = UIBarStyleBlack;
//    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate.rootController.view insertSubview:_navController.view atIndex:100];
    
}

- (void)showSpinner{
    UIView *overlay = [[UIView alloc] initWithFrame:_controller.view.frame];
    overlay.backgroundColor = [UIColor blackColor];
    overlay.alpha = 0.5f;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    spinner.center = overlay.center;
    [overlay addSubview:spinner];
    
    [_controller.view addSubview:overlay];
}

#pragma mark -
#pragma mark Session
- (void)login:(void(^)(BOOL))callback{
    if (self.session.state != FBSessionStateCreated) {
        // Create a new, logged out session.
        self.session = [[FBSession alloc] init];
    }
    
    // if the session isn't open, let's open it now and present the login UX to the user
    [self.session openWithCompletionHandler:^(FBSession *session,
                                              FBSessionState status,
                                              NSError *error) {
        if(!error){
            [self showViewController];
            if(callback)
                callback(YES);
        }
        else{
            [self showAlertWithText:[NSString stringWithFormat:@"Something went wrong.\n%@",error]];
        }
    }];
}

- (void)logout{
    if (self.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [self.session close];
        [self.session closeAndClearTokenInformation];
    }
}

- (BOOL)isAuthenticated{
    if (self.session.isOpen) {
        return YES;
    }
    return NO;
}

#pragma mark - FBViewController delegate
- (void)_didPost:(NSMutableDictionary *)param{
    [Flurry logEvent:@"Faceook_post"];
    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Faceook_post" withValue:nil];
    [self publishStory:param];
}

- (void)_didCancel{
    _controller.delegate = nil;
    _controller = nil;
    [_navController.view removeFromSuperview];
}
@end
