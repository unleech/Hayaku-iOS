//
//  FacebookVeiwController.m
//  FacebookTest
//
//  Created by martin magalong on 12/8/12.
//  Copyright (c) 2012 ripplewave. All rights reserved.
//

#import "FacebookVeiwController.h"

@implementation FacebookVeiwController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
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
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = buttonDone;
    
    UIBarButtonItem *buttonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = buttonCancel;
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10,10,300,150)];
//    _textView.font = [UIFont fontWithName:kFontLucidaGrande size:KFontSize15];
    [self.view addSubview:_textView];
    
    [_textView becomeFirstResponder];
}

- (void)cancel{
    [self.delegate _didCancel];
}

- (void)done{
    
    _parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"http://londoncalling.com",@"link",
                   @"http://a0.twimg.com/profile_images/1930165194/Pinterest-avatar_normal.jpg", @"picture",
                   @"London Calling", @"name",
                   @"Get recommendations on the best London attractions, venues and events, and organise your trip with our handy cultural planner", @"caption",
                   //@"Visit us to see more exciting happenings.", @"description",
                   @"",@"place",_textView.text,@"message",nil];
    
    [self.delegate _didPost:_parameters];
}
- (void)dealloc{
    NSLog(@"%@ deallocated!",[self class]);
}

-(BOOL)shouldAutorotate
{
    return UIInterfaceOrientationLandscapeRight;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationLandscapeRight;
}
@end
