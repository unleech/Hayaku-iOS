//
//  ToolShopScreen.m
//  Unity-iPhone
//
//  Created by Jan Michael on 2/27/13.
//
//

#import "ToolShopScreen.h"
#import "SplashScreen.h"
#import "CustomCell.h"

@interface ToolShopScreen ()

@end

@implementation ToolShopScreen

@synthesize listToolShop;
@synthesize containerCostumes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_backButton.titleLabel setFont:[UIFont fontWithName:@"Vanilla" size:14]];
    [_costumesButton.titleLabel setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:14]];
    [_utilitiesButton.titleLabel setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:14]];
    [_moreButton.titleLabel setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:14]];
    [_labelCakes setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:14]];
    [_labelCoins setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:14]];
    [_labelEquipped setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:10]];
    [_labelCostume setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:11]];
    [_labelBuff setFont:[UIFont fontWithName:@"Visitor TT1 BRK" size:11]];
    
    [_costumesButton setSelected:YES];
    
    [self reloadShop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_backButton release];
    [_labelCoins release];
    [_labelCakes release];
    [_costumesButton release];
    [_utilitiesButton release];
    [_utilitiesButton release];
    [_moreButton release];
    [_labelEquipped release];
    [_labelCostume release];
    [_labelBuff release];
    [_imageChar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setBackButton:nil];
    [self setLabelCoins:nil];
    [self setLabelCakes:nil];
    [self setCostumesButton:nil];
    [self setUtilitiesButton:nil];
    [self setUtilitiesButton:nil];
    [self setMoreButton:nil];
    [self setLabelEquipped:nil];
    [self setLabelCostume:nil];
    [self setLabelBuff:nil];
    [self setImageChar:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return containerCostumes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomCell alloc] initWithStyleCS:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withTableWidth:tableView.frame.size.width withRowHeight:tableView.rowHeight] autorelease];
    }
    
    // Configure the cell...
    if (_costumesButton.selected) {
        NSDictionary *tempDict = [containerCostumes objectAtIndex:indexPath.row];
        cell.costumeName.text = [tempDict objectForKey:@"costume"];
        cell.buff.text = [tempDict objectForKey:@"buff"];
        cell.cost.text = [tempDict objectForKey:@"cost"];
        [cell.portrait setImage:[UIImage imageNamed:[tempDict objectForKey:@"image"]]];
        
        if ([[tempDict objectForKey:@"costIcon"] isEqualToString:@"Cake"]) {
            [cell.costIcon setImage:[UIImage imageNamed:@"HudCakeIndicator.png"]];
        }
        else {
            [cell.costIcon setImage:[UIImage imageNamed:@"HudCoinIndicator.png"]];
        }
        
        if ([[tempDict objectForKey:@"purchased"] boolValue]) {
            if ([[tempDict objectForKey:@"equipped"] boolValue]) {
                _labelCostume.text = [tempDict objectForKey:@"costume"];
                _labelBuff.text = [tempDict objectForKey:@"buff"];
                [_imageChar setImage:[UIImage imageNamed:[tempDict objectForKey:@"image"]]];
                [cell.equipButton setTitle:@"Unequip" forState:UIControlStateNormal];
            }
            else {
                [cell.equipButton setTitle:@"Equip" forState:UIControlStateNormal];
            }
        }
        else {
            [cell.equipButton setTitle:@"Buy" forState:UIControlStateNormal];
        }
        [cell.equipButton addTarget:self action:@selector(onEquipButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.equipButton.tag = indexPath.row;
    }
    
    
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
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
     [detailViewController release];
     */
}

#pragma mark -
- (IBAction)onBackButton:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
    [[SplashScreen sharedInstance] gotoMainMenu];
    
}

- (IBAction)onCostumesbutton:(UIButton *)sender {
    _costumesButton.selected = YES;
    _utilitiesButton.selected = NO;
    _moreButton.selected = NO;
    
    [self reloadShop];
}

- (IBAction)onUtilitiesButton:(UIButton *)sender {
    _costumesButton.selected = NO;
    _utilitiesButton.selected = YES;
    _moreButton.selected = NO;
    
    [self reloadShop];
}

- (IBAction)onMoreButton:(UIButton *)sender {
    _costumesButton.selected = NO;
    _utilitiesButton.selected = NO;
    _moreButton.selected = YES;
    
    [self reloadShop];
}

#pragma mark -
- (void)onEquipButton:(UIButton *)sender
{
    NSMutableDictionary *listCostume = [containerCostumes objectAtIndex:sender.tag];
    
    if ([[listCostume objectForKey:@"purchased"] boolValue]) {
        if ([[listCostume objectForKey:@"equipped"] boolValue]) {
            //unequip
        }
        else {
            //equip
            [self equip:listCostume];
        }
        
    }
    else {
        //purchase
        [self buy:listCostume];
    }
    
    //write to file
    [self saveData:listCostume sender:sender];
    //reloadShop
    [self reloadShop];
}

- (void)equip:(NSMutableDictionary *)listCostume
{
    for (NSMutableDictionary *temp in containerCostumes) {
        [temp setObject:@"NO" forKey:@"equipped"];
    }

    [listCostume setObject:@"YES" forKey:@"equipped"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@{@"selectedCharacter" : [listCostume objectForKey:@"image"]} forKey:@"listCharacters"];
}

- (void)buy:(NSMutableDictionary *)listCostume
{
    int totalMoney = 0;
    int totalSpent = 0;
    int cost = [[listCostume objectForKey:@"cost"] intValue];
    
    if ([[listCostume objectForKey:@"costIcon"] isEqualToString:@"Cake"]) {
        totalMoney = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalCakes"];
        totalSpent = [[NSUserDefaults standardUserDefaults] integerForKey:@"spentCakes"];
        
        if (cost <= totalMoney - totalSpent) {
            [[NSUserDefaults standardUserDefaults] setInteger:totalSpent+cost forKey:@"spentCakes"];
            [listCostume setObject:@"YES" forKey:@"purchased"];
        }
        else {
            //not enough
            NSLog(@"alert not enough cake");
        }
    }
    else {
        totalMoney = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalCoins"];
        totalSpent = [[NSUserDefaults standardUserDefaults] integerForKey:@"spentCoins"];

        if (cost <= totalMoney - totalSpent) {
            [[NSUserDefaults standardUserDefaults] setInteger:totalSpent+cost forKey:@"spentCoins"];
            [listCostume setObject:@"YES" forKey:@"purchased"];
        }
        else {
            //not enough
            NSLog(@"alert not enough coin");
        }
    }
    
    
}

- (void)saveData:(NSMutableDictionary *)listCostume sender:(UIButton *)sender
{
    NSMutableDictionary *tempMDict = [[NSMutableDictionary alloc] initWithDictionary:listToolShop];
    NSMutableArray *tempArray = [[tempMDict objectForKey:@"Costumes"] mutableCopy];
    [tempArray replaceObjectAtIndex:sender.tag withObject:listCostume];
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectoryPath
//                      stringByAppendingPathComponent:@"ToolShop.plist"];
//
//    [tempMDict writeToFile:path atomically: YES];

//    id plist = [NSPropertyListSerialization dataWithPropertyList:tempMDict format:0 options:NSPropertyListMutableContainersAndLeaves error:nil];
    
    [[SplashScreen sharedInstance] saveData:tempMDict as:@"ToolShop.bin"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reloadShop
{
    _labelCakes.text = [NSString stringWithFormat:@"x%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"totalCakes"] - [[NSUserDefaults standardUserDefaults] integerForKey:@"spentCakes"]];
    _labelCoins.text = [NSString stringWithFormat:@"x%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"totalCoins"] - [[NSUserDefaults standardUserDefaults] integerForKey:@"spentCoins"]];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectoryPath
//                      stringByAppendingPathComponent:@"ToolShop.plist"];
    
    if (_costumesButton.selected) {
//        listToolShop =  [[NSDictionary dictionaryWithContentsOfFile:path] retain];
        listToolShop = [[[SplashScreen sharedInstance] loadData:@"ToolShop.bin"] retain];
        containerCostumes = [listToolShop objectForKey:@"Costumes"];
    }
    else {
        listToolShop = nil;
        containerCostumes = nil;
    }
    
    [_tableView reloadData];
}

@end
