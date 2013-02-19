//
//  SplashScreen.m
//  Unity-iPhone
//
//  Created by Jan Michael on 2/14/13.
//
//

#import "UnityNativeManager.h"

#import "SplashScreen.h"

#import <Social/Social.h>
#import <Twitter/Twitter.h>

#import "CustomAlert.h"

#import "Flurry.h"
#import "GAI.h"

#import "AppController.h"

@interface SplashScreen ()
@property (retain, nonatomic) IBOutlet UIImageView *Logo;
@property (retain, nonatomic) IBOutlet UIButton *PlayButton;
@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (retain, nonatomic) IBOutlet UIView *mapSceneView;
@property (retain, nonatomic) IBOutlet UIButton *button_map_cliff;
@property (retain, nonatomic) IBOutlet UIButton *button_map_warehouse;
@property (retain, nonatomic) IBOutlet UIButton *button_map_temple;
@property (retain, nonatomic) IBOutlet UIButton *button_map_castle;
@property (retain, nonatomic) IBOutlet UIView *loadingView;
@property (retain, nonatomic) IBOutlet UIImageView *hudInfo;
@property (retain, nonatomic) IBOutlet UIImageView *hudHP;
@property (retain, nonatomic) IBOutlet UIImageView *hudMP;
@property (retain, nonatomic) IBOutlet UIImageView *hudCombo;



- (IBAction)onPlayButton:(UIButton *)sender;
- (IBAction)onCliffButton:(UIButton *)sender;
- (IBAction)onWarehouseButton:(UIButton *)sender;
- (IBAction)onTempleButton:(UIButton *)sender;
- (IBAction)onCastleButton:(UIButton *)sender;


@end

@implementation SplashScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"initS");
        
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        _fbManager = delegate.fbManager;
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"didloadS");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSString *tempString = [[NSUserDefaults standardUserDefaults] objectForKey:@"SplashScreen"];
    
    if ([tempString isEqualToString:@"1"]) {
        //insert loading screen for x seconds... then show menu
        [self performSelector:@selector(gotoMainMenu) withObject:nil afterDelay:0.1f];
    }
    else if ([tempString isEqualToString:@"2"]) {
        //insert loading screen for x seconds... then show menu
        [self performSelector:@selector(gotoMainMenu) withObject:nil afterDelay:0.1f];
    }
    else if ([tempString isEqualToString:@"3"]) {
        //insert loading screen for x seconds... then show menu
        [self performSelector:@selector(gotoMapScene) withObject:nil afterDelay:0.1f];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_Logo release];
    [_PlayButton release];
    [_button_map_cliff release];
    [_button_map_warehouse release];
    [_button_map_temple release];
    [_button_map_castle release];
    [_mapSceneView release];
    [_loadingView release];
    [_hudInfo release];
    [_hudHP release];
    [_hudMP release];
    [_hudCombo release];
    [_mainView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLogo:nil];
    [self setPlayButton:nil];
    [self setButton_map_cliff:nil];
    [self setButton_map_warehouse:nil];
    [self setButton_map_temple:nil];
    [self setButton_map_castle:nil];
    [self setMapSceneView:nil];
    [self setLoadingView:nil];
    [self setHudInfo:nil];
    [self setHudHP:nil];
    [self setHudMP:nil];
    [self setHudCombo:nil];
    [self setMainView:nil];
    [super viewDidUnload];
}

- (void)gotoMainMenu
{
    _Logo.hidden = NO;
    _Logo.alpha = 0;
    
    _PlayButton.hidden = NO;
    _PlayButton.alpha = 0;
    CGRect temp = _PlayButton.frame;
    [_PlayButton setFrame:CGRectMake(temp.origin.x + 300, temp.origin.y, temp.size.width, temp.size.height)];
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _Logo.alpha = 1;
                         
                         _PlayButton.alpha = 1;
                         [_PlayButton setFrame:temp];
                     }
                     completion:^(BOOL completed) {}];
    
}


#pragma mark - MAIN MENU
- (IBAction)onPlayButton:(UIButton *)sender {
    
    CGRect temp = _PlayButton.frame;
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _PlayButton.alpha = 0;
                         [_PlayButton setFrame:CGRectMake(temp.origin.x + 300, temp.origin.y, temp.size.width, temp.size.height)];
                         
                         _Logo.alpha = 0;
                     }
                     completion:^(BOOL completed) {
                         [self gotoMapScene];
                     }];
    
}

- (void) gotoMapScene
{
    _mapSceneView.hidden = NO;
    
    _button_map_castle.hidden = NO;
    _button_map_castle.alpha = 0;
    _button_map_cliff.hidden = NO;
    _button_map_cliff.alpha = 0;
    _button_map_temple.hidden = NO;
    _button_map_temple.alpha = 0;
    _button_map_warehouse.hidden = NO;
    _button_map_warehouse.alpha = 0;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _button_map_castle.alpha = 1;
                         _button_map_cliff.alpha = 1;
                         _button_map_temple.alpha = 1;
                         _button_map_warehouse.alpha = 1;
                     }
                     completion:^(BOOL completed) {}];
}

#pragma mark - MAP SCENE
- (IBAction)onCliffButton:(UIButton *)sender {
    
    [[UnityNativeManager sharedManager] pauseUnity:NO];
    
    NSDictionary *tempDict = @{@"Scene" : @"GameScene", @"Stage" : @"Cliff"};

//    NSMutableData *data = [[NSMutableData alloc]init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [archiver encodeObject:tempDict forKey: @"1"];
//    [archiver finishEncoding];


    
    
    NSString *tempString;
    tempString = [NSString stringWithFormat:@"%@", tempDict];
	UnitySendMessage( "UnityGameController", "loadLevel", [@"GameScene_1" UTF8String]);
}

- (IBAction)onWarehouseButton:(UIButton *)sender {
    
    [[UnityNativeManager sharedManager] pauseUnity:NO];
	UnitySendMessage( "UnityGameController", "loadLevel", [@"GameScene_2" UTF8String] );
}

- (IBAction)onTempleButton:(UIButton *)sender {
    
    [[UnityNativeManager sharedManager] pauseUnity:NO];
	UnitySendMessage( "UnityGameController", "loadLevel", [@"GameScene_3" UTF8String] );
}

- (IBAction)onCastleButton:(UIButton *)sender {

//    [self publishFB];
    [[UnityNativeManager sharedManager] pauseUnity:NO];
	UnitySendMessage( "UnityGameController", "loadLevel", [@"GameScene_4" UTF8String] );
}


#pragma mark - SOCIAL FB
- (void)publishFB
{
    [Flurry logEvent:@"Faceook_buttonP"];
    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Faceook" withValue:nil];
    
    if([SLComposeViewController instanceMethodForSelector:@selector(isAvailableForServiceType)] != nil){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
            
            //willShowFBiOS6 = YES;
            
//            UIActivityIndicatorView *_spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            _spinner.color = [UIColor colorWithRed:0.92 green:0 blue:0.45 alpha:1];
//            _spinner.frame = CGRectMake(sender.frame.origin.x + sender.frame.size.width/2-10, sender.frame.origin.y +sender.frame.size.height + 10, 20, 20);
//            [_spinner startAnimating];
//            _spinner.tag = 999;
//            [self.view addSubview:_spinner];
            
            
            
//            if (objectData? objectData.thumbnail:objectData2.thumbnail) {
//                [[GameHandler sharedInstance].imageDownloader loadImageFromUrl:[NSURL URLWithString:objectData? objectData.thumbnail:objectData2.thumbnail] withKey:objectData? objectData.thumbnail:objectData2.thumbnail];
//                [self cachedThumbnailReady];
//            }
//            else {
//                willShowFBiOS6 = NO;
//                [self removeSpinner];
                [self presentFBiOS6];
//            }
            
        }
        else
        {
            NSLog(@"FB not available!");
            [Flurry logEvent:@"Faceook_N/A"];
            [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Error" withAction:@"Press" withLabel:@"Faceook_N/A" withValue:nil];
        }
    }
    else{
        [_fbManager login:nil];
    }

}

- (void)presentFBiOS6
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled)
        {
            NSLog(@"Cancelled");
            [Flurry logEvent:@"Faceook_Cancelled"];
            [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Faceook_Cancelled" withValue:nil];
        }
        else
        {
            NSLog(@"Done");
            [Flurry logEvent:@"Faceook_Done"];
            [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Faceook_Done" withValue:nil];
        }
        [controller dismissViewControllerAnimated:YES completion:Nil];
    };
    controller.completionHandler = myBlock;
    
    
    [controller setInitialText:@"I love this app!"];
    [controller addURL:[NSURL URLWithString:@"http://londoncalling.com"]];
    
    UIImageView* fbIconAttach = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
    
//    [fbIconAttach setImageWithURL:[NSURL URLWithString:objectData? objectData.thumbnail:objectData2.thumbnail] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    
    [controller addImage:fbIconAttach.image];
    [self presentViewController:controller animated:YES completion:Nil];
}


#pragma mark - Twitter
- (void)sendTweet{
    [Flurry logEvent:@"Twitter_buttonP"];
    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Twitter" withValue:nil];
    if ([TWTweetComposeViewController canSendTweet])
    {
        TWTweetComposeViewController *tweetSheet =
        [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:@"I love this app! http://londoncalling.com"];
        
        //[tweetSheet addImage:@""];
        //[tweetSheet addURL:@""];
        [self presentModalViewController:tweetSheet animated:YES];
        [Flurry logEvent:@"Twitter_tweet"];
        [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Twitter_tweet" withValue:nil];
    }
    else
    {
        [Flurry logEvent:@"Twitter_Failed"];
        [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Button" withAction:@"Press" withLabel:@"Twitter_Sorry" withValue:nil];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry" message:@"Make sure your device has an internet connection and your Twitter account has been set up."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:@"Go to Settings!",nil];
        [alertView show];
    }
    
}
@end
