//
//  twitterFeed.h
//  London
//
//  Created by John Michael on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

@interface TwitterFeed : Menu <UITableViewDelegate, UITableViewDataSource>
{
    int page, rpp;
    NSString *q;
    bool isRequestDone;
    UIActivityIndicatorView *loadingCircle;
    UITableView* tableView;
    ASIHTTPRequest *dataRequest;
}
@property(nonatomic,retain) NSMutableArray* tweets;

- (id)initWithFrame:(CGRect)frame;

@end
