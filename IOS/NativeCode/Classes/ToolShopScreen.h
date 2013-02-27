//
//  ToolShopScreen.h
//  Unity-iPhone
//
//  Created by Jan Michael on 2/27/13.
//
//

#import <UIKit/UIKit.h>

@interface ToolShopScreen : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (retain, nonatomic)    NSDictionary *listToolShop;
@property (retain, nonatomic)    NSArray *containerCostumes;

@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UILabel *labelEquipped;
@property (retain, nonatomic) IBOutlet UILabel *labelCostume;
@property (retain, nonatomic) IBOutlet UILabel *labelBuff;
@property (retain, nonatomic) IBOutlet UIImageView *imageChar;

@property (retain, nonatomic) IBOutlet UILabel *labelCoins;
@property (retain, nonatomic) IBOutlet UILabel *labelCakes;

@property (retain, nonatomic) IBOutlet UIButton *costumesButton;
@property (retain, nonatomic) IBOutlet UIButton *utilitiesButton;
@property (retain, nonatomic) IBOutlet UIButton *moreButton;

- (IBAction)onBackButton:(UIButton *)sender;
- (IBAction)onCostumesbutton:(UIButton *)sender;
- (IBAction)onUtilitiesButton:(UIButton *)sender;
- (IBAction)onMoreButton:(UIButton *)sender;


@end
