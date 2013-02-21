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
enum eScene
{
    eMainMenuScene,
    eGameScene
};

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

@property (retain, nonatomic) IBOutlet UIView *objectiveView;
@property (retain, nonatomic) IBOutlet UIImageView *mission1;
@property (retain, nonatomic) IBOutlet UIImageView *mission2;
@property (retain, nonatomic) IBOutlet UIImageView *mission3;
@property (retain, nonatomic) IBOutlet UIImageView *mission4;
@property (retain, nonatomic) IBOutlet UIButton *buttonPlay;
@property (retain, nonatomic) IBOutlet UIButton *buttonBack;


- (IBAction)onPlayButton:(UIButton *)sender;
- (IBAction)onCliffButton:(UIButton *)sender;
- (IBAction)onWarehouseButton:(UIButton *)sender;
- (IBAction)onTempleButton:(UIButton *)sender;
- (IBAction)onCastleButton:(UIButton *)sender;
- (IBAction)onPlayGame:(UIButton *)sender;
- (IBAction)onBack:(UIButton *)sender;


@end

@implementation SplashScreen
static SplashScreen* _splashScreen = nil;

+ (id) sharedInstance
{
	
	if (!_splashScreen)
	{
		
		_splashScreen = [[self alloc] initWithNibName:nil bundle:nil];
	}
	
	return _splashScreen;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        _fbManager = delegate.fbManager;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *tempString = [[NSUserDefaults standardUserDefaults] objectForKey:@"SplashScreen"];
    
    if ([tempString isEqualToString:@"1"]) {
        //insert loading screen for x seconds... then show menu
        [self performSelector:@selector(gotoSplashScreen:) withObject:[NSNumber numberWithInt:eMainMenuScene] afterDelay:0.1f];
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
    [_objectiveView release];
    [_mission1 release];
    [_mission2 release];
    [_mission3 release];
    [_mission4 release];
    [_buttonPlay release];
    [_buttonBack release];
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
    [self setObjectiveView:nil];
    [self setMission1:nil];
    [self setMission2:nil];
    [self setMission3:nil];
    [self setMission4:nil];
    [self setButtonPlay:nil];
    [self setButtonBack:nil];
    [super viewDidUnload];
}

#pragma mark - Splash Screen
- (void)gotoSplashScreen:(NSNumber *)scene
{
    //loading
    _mapSceneView.hidden = YES;
    _loadingView.hidden = NO;
    _loadingView.alpha = 0;
    _hudInfo.hidden = NO;
    _hudInfo.alpha = 0;
    
    counter = 0;
    counterHP = 0;
    counterMP = 0;
    [self setHP:counterHP];
    [self setMP:counterMP];
    [self setCombo:counter];
    
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _loadingView.alpha = 1;
                         _hudInfo.alpha = 1;
                         
                     }
                     completion:^(BOOL completed) {
                         [self loadScreen:scene];
                     }];
}

- (void)loadScreen:(NSNumber *)scene
{
    [self setCombo:counter];
    
    if (counter >= 7) {
        counterHP++;
        counterMP++;
        [self setHP:counterHP];
        [self setMP:counterMP];
        counter = -1;
    }
    
    if (counterHP >= 3 && counterMP >=3) {
        if ([scene intValue] == eMainMenuScene) {
            [UIView animateWithDuration:1
                                  delay:0
                                options:(UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 _loadingView.alpha = 0;
                             }
                             completion:^(BOOL completed) {
                                 [self gotoMainMenu];
                             }];
        }
        else if ([scene intValue] == eGameScene) {
            [UIView animateWithDuration:0.5f
                                  delay:0
                                options:(UIViewAnimationOptionTransitionNone)
                             animations:^{
                                 _mainView.alpha = 0;
                                 _mapSceneView.alpha = 0;
                             }
                             completion:^(BOOL completed) {
                                 [[UnityNativeManager sharedManager] hideViewController]; //sets the view to 100,100
                                 _mainView.hidden = YES;
                                 _mapSceneView.hidden = YES;
                             }];
        }
    }
    else {
        counter++;
        [self performSelector:@selector(loadScreen:) withObject:scene afterDelay:0.05f];
    }
    
}

#pragma mark - SetInfoBars

- (void)setHP:(int) count
{
    switch (count) {
        case 0:
            _hudHP.hidden = YES;
            break;
        case 1:
            _hudHP.image = [UIImage imageNamed:@"HudHealthTick1"];
            _hudHP.hidden = NO;
            break;
        case 2:
            _hudHP.image = [UIImage imageNamed:@"HudHealthTick2"];
            _hudHP.hidden = NO;
            break;
        case 3:
            _hudHP.image = [UIImage imageNamed:@"HudHealthTick3"];
            _hudHP.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)setMP:(int) count
{
    switch (count) {
        case 0:
            _hudMP.hidden = YES;
            break;
        case 1:
            _hudMP.image = [UIImage imageNamed:@"HudManaTick1"];
            _hudMP.hidden = NO;
            break;
        case 2:
            _hudMP.image = [UIImage imageNamed:@"HudManaTick2"];
            _hudMP.hidden = NO;
            break;
        case 3:
            _hudMP.image = [UIImage imageNamed:@"HudManaTick3"];
            _hudMP.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)setCombo:(int) count
{
    switch (count) {
        case 0:
            _hudCombo.hidden = YES;
            break;
        case 1:
            _hudCombo.image = [UIImage imageNamed:@"HudComboTick1"];
            _hudCombo.hidden = NO;
            break;
        case 2:
            _hudCombo.image = [UIImage imageNamed:@"HudComboTick2"];
            _hudCombo.hidden = NO;
            break;
        case 3:
            _hudCombo.image = [UIImage imageNamed:@"HudComboTick3"];
            _hudCombo.hidden = NO;
            break;
        case 4:
            _hudCombo.image = [UIImage imageNamed:@"HudComboTick4"];
            _hudCombo.hidden = NO;
            break;
        case 5:
            _hudCombo.image = [UIImage imageNamed:@"HudComboTick5"];
            _hudCombo.hidden = NO;
            break;
        case 6:
            _hudCombo.image = [UIImage imageNamed:@"HudComboTick6"];
            _hudCombo.hidden = NO;
            break;
        default:
            break;
    }
}

#pragma mark - Main Menu

- (void)gotoMainMenu
{
    _loadingView.hidden = YES;
    _mainView.hidden = NO;
    _mainView.alpha = 1;
    
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
                         [_PlayButton setFrame:CGRectMake(temp.origin.x, temp.origin.y, temp.size.width, temp.size.height)];
                     }];
    
}

- (void) gotoMapScene
{
    _mainView.hidden = NO;
    _mapSceneView.hidden = NO;
    _mapSceneView.alpha = 1;
    
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
    _objectiveView.hidden = NO;
    _mission1.hidden = NO;
}

- (IBAction)onWarehouseButton:(UIButton *)sender {
    _objectiveView.hidden = NO;
    _mission2.hidden = NO;
}

- (IBAction)onTempleButton:(UIButton *)sender {
    _objectiveView.hidden = NO;
    _mission3.hidden = NO;
}

- (IBAction)onCastleButton:(UIButton *)sender {
    _objectiveView.hidden = NO;
    _mission4.hidden = NO;
}

- (IBAction)onPlayGame:(UIButton *)sender {
    NSString *tempString;
    
    if (!_mission1.hidden) {
        tempString = @"GameScene_1";
    }
    else if (!_mission2.hidden) {
        tempString = @"GameScene_2";
    }
    else if (!_mission3.hidden) {
        tempString = @"GameScene_3";
    }
    else if (!_mission4.hidden) {
        tempString = @"GameScene_4";
    }
    
    NSString *tempStringCharacter = @"player";
    
    _objectiveView.hidden = YES;
    _mission1.hidden = YES;
    _mission2.hidden = YES;
    _mission3.hidden = YES;
    _mission4.hidden = YES;
    
    [self gotoSplashScreen:[NSNumber numberWithInt:eGameScene]];
    
    [[UnityNativeManager sharedManager] pauseUnity:NO];
    UnitySendMessage( "UnityGameController", "loadLevel", [tempString UTF8String]);    
    UnitySendMessage( "UnityGameController", "selectedCharacter", [tempStringCharacter UTF8String]);
}

- (IBAction)onBack:(UIButton *)sender {
    
    if (_objectiveView.hidden) {
        _mapSceneView.hidden = YES;
        [self gotoMainMenu];
    }
    else {
        _objectiveView.hidden = YES;
        _mission1.hidden = YES;
        _mission2.hidden = YES;
        _mission3.hidden = YES;
        _mission4.hidden = YES;
    }
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
