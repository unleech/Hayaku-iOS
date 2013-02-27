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
    
    
    _labelCakes.text = [NSString stringWithFormat:@"x%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"totalCakes"] - [[NSUserDefaults standardUserDefaults] integerForKey:@"spentCakes"]];
    _labelCoins.text = [NSString stringWithFormat:@"x%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"totalCoins"] - [[NSUserDefaults standardUserDefaults] integerForKey:@"spentCoins"]];
    
    
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
}

- (IBAction)onUtilitiesButton:(UIButton *)sender {
}

- (IBAction)onMoreButton:(UIButton *)sender {
}

#pragma mark -
- (void)onEquipButton:(UIButton *)sender
{
    NSMutableDictionary *listCostume = [containerCostumes objectAtIndex:sender.tag];
    
    if ([listCostume objectForKey:@"purchased"]) {
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
    }
    
    NSMutableDictionary *tempMDict = [[NSMutableDictionary alloc] initWithDictionary:listToolShop];
    [tempMDict setObject:listCostume forKey:@"Costumes"];
    //write to file
    //reloadShop
}

- (void)equip:(NSMutableDictionary *)listCostume
{
    for (NSMutableDictionary *temp in containerCostumes) {
        [temp setObject:@"NO" forKey:@"equipped"];
    }

    [listCostume setObject:@"YES" forKey:@"equipped"];
}

- (void)reloadShop
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath
                      stringByAppendingPathComponent:@"ToolShop.plist"];
    
    listToolShop =  [[NSDictionary dictionaryWithContentsOfFile:path] retain];
    containerCostumes = [listToolShop objectForKey:@"Costumes"];
    
    [_tableView reloadData];
}

@end
