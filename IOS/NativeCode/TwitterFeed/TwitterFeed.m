//
//  twitterFeed.m
//  London
//
//  Created by John Michael on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterFeed.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "MyLabel.h"

#define tweetURL @"http://search.twitter.com/search.json?"
#define query @"@LondonCallingUK"
#define returnPerPage 10
#define startingPageNumber 1
@interface TwitterFeed ()

@end

@implementation TwitterFeed

@synthesize tweets = _tweets;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self != nil)
    {
        //default
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [bg setImage:[UIImage imageNamed:@"mainBG.png"]];
        [self.view addSubview:bg];
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(240, 0, 80, 80)];
        [logo setImage:[UIImage imageNamed:@"logo2.png"]];
        [self.view addSubview:logo];
        
            UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(0, 50, 90, 36);
    [buttonBack setBackgroundColor:[UIColor clearColor]];
    [buttonBack setContentMode:UIViewContentModeScaleAspectFit];
    [buttonBack setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [buttonBack setImage:[UIImage imageNamed:@"backButton_p.png"] forState:UIControlStateHighlighted];
    [buttonBack addTarget:self action:@selector(buttonBackPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
        
        
        
//        self.view.frame = frame; 
        self.view.frame = CGRectMake(0, 0, 320, 480);

        // Custom initialization
        _tweets = [[NSMutableArray alloc] init];
        
        q = query;
        rpp = returnPerPage;
        page = startingPageNumber;
        [self getDataFromServerWithLink:[NSURL URLWithString:[NSString stringWithFormat:@"%@q=%@&rpp=%d&page=%d", tweetURL, q, rpp, page]] withType:@"results"];
        
//        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, 320, 375) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.backgroundColor = [UIColor clearColor];
//        tableView.separatorColor = [UIColor clearColor];
        tableView.rowHeight = 81;
        
        [self.view addSubview:tableView];

        
        loadingCircle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingCircle setFrame:CGRectMake(0, 0, 24, 24)];
        [loadingCircle setCenter:tableView.center];
        [self.view addSubview:loadingCircle];

        [loadingCircle startAnimating];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _tweets.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) 
    {        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.tag = indexPath.row;
    }
    
    MyLabel *tweet = [[MyLabel alloc] initWithFrame:CGRectMake(2, 2, 290, 58) withText:[NSString stringWithFormat:@"%@", [[_tweets objectAtIndex:indexPath.row] objectForKey:@"text"]] withFontName:nil withFontSize:12];
    tweet.numberOfLines = 4;

    
    [cell addSubview: tweet];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - (tableView.frame.size.height);
    if (actualPosition >= contentHeight) 
    {
        if (isRequestDone) {
//            NSLog(@"end of scroll, show more");
            
            isRequestDone = NO;
            page++;
            [self getDataFromServerWithLink:[NSURL URLWithString:[NSString stringWithFormat:@"%@q=%@&rpp=%d&page=%d", tweetURL, q, rpp, page]] withType:@"results"];
        }
    }
}

#pragma mark DataRequests
- (void)getDataFromServerWithLink:(NSString*)link withType:(NSString*)type
{
//    NSLog(@"starting your data request from server . . .");
    [loadingCircle startAnimating];
    
    NSString *url = [NSString stringWithFormat:@"%@",link];
    dataRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [dataRequest setDelegate:self];
    dataRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",link,@"link", nil];
    
    [dataRequest setDidFinishSelector:@selector(didSucceedDataRequest:)];
    [dataRequest setDidFailSelector:@selector(didFailDataRequest:)];	
    [dataRequest startAsynchronous];
}

- (void)didSucceedDataRequest:(ASIHTTPRequest*)request
{
    [loadingCircle stopAnimating];
    NSArray *parsedJSONResult = [[[request responseString] objectFromJSONString] objectForKey:@"results"];
    [_tweets addObjectsFromArray:parsedJSONResult];
    [tableView reloadData];
    isRequestDone = YES;
}

- (void)didFailDataRequest:(ASIHTTPRequest*)request
{
//    NSLog(@"didFailDataRequest");
    [loadingCircle stopAnimating];
    isRequestDone = YES;
}

#pragma mark - Default Methods
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [dataRequest setDelegate:nil];
}
@end
