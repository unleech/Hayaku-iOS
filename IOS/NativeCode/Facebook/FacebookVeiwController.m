//
//  FacebookVeiwController.m
//  FacebookTest
//
//  Created by martin magalong on 12/8/12.
//  Copyright (c) 2012 ripplewave. All rights reserved.
//

#import "FacebookVeiwController.h"
#import "SaveFile.h"
#import "LCData.h"
#import "GameHandler.h"

@implementation FacebookVeiwController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake (0,0,320,480);
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView *overlay = [[UIView alloc]init];
    overlay.frame = self.view.frame;
    overlay.backgroundColor = [UIColor whiteColor];
    overlay.alpha = 0.5f;
    [self.view addSubview:overlay];
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button1 setTitle:@"Post" forState:UIControlStateNormal];
//    button1.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//    button1.frame = CGRectMake(0, 0, 30, 30);
//    [button1 addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = buttonDone;
    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button2 setTitle:@"Cancel" forState:UIControlStateNormal];
//    button2.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//    button2.frame = CGRectMake(0, 0, 30, 30);
//    [button2 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *buttonCancel = [[UIBarButtonItem alloc] initWithCustomView:button2];
    UIBarButtonItem *buttonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = buttonCancel;
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10,10,300,150)];
    _textView.font = [UIFont fontWithName:kFontLucidaGrande size:KFontSize15];
    [self.view addSubview:_textView];

    if ([SaveFile sharedFile].lastKnownURL) {
        _textView.text = [NSString stringWithFormat:@"Check out this cool event!"];
    }
    [_textView becomeFirstResponder];
}

- (void)cancel{
    [self.delegate _didCancel];
}

- (void)done{
    LCData *objectData = [[GameHandler sharedInstance].dataManager loadObjectWithKey:[SaveFile sharedFile].lastKnownURL];
    
    if (objectData) {
        _parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:objectData.fullURL,@"link",
                       objectData.thumbnail, @"picture",
                       objectData.title, @"name",
                       @"", @"caption",
                       //@"Visit us to see more exciting happenings.", @"description",
                       @"",@"place",_textView.text,@"message",nil];
    }
    else {
        _parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"http://londoncalling.com",@"link",
                       @"http://a0.twimg.com/profile_images/1930165194/Pinterest-avatar_normal.jpg", @"picture",
                       @"London Calling", @"name",
                       @"Get recommendations on the best London attractions, venues and events, and organise your trip with our handy cultural planner", @"caption",
                       //@"Visit us to see more exciting happenings.", @"description",
                       @"",@"place",_textView.text,@"message",nil];
    }
    [self.delegate _didPost:_parameters];
}
- (void)dealloc{
    NSLog(@"%@ deallocated!",[self class]);
}
@end
