//
//  CustomCell.m
//  Unity-iPhone
//
//  Created by Jan Michael on 2/26/13.
//
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize portrait;
@synthesize buff;
@synthesize costumeName;
@synthesize cost;
@synthesize costIcon;
@synthesize equipButton;

- (id)initWithStyleCS:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTableWidth:(float)width withRowHeight:(float)rowHeight
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, rowHeight)];
//        [self addSubview:bg];

        UIImageView *portraitBG = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        portraitBG.image = [UIImage imageNamed:@"toolshop_pic.png"];
        [self addSubview:portraitBG];
        
        portrait = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 48, 48)];
        portrait.image = [UIImage imageNamed:@"toolshop_pic.png"];
        [self addSubview:portrait];
        
        costumeName = [[CustomLabelFont alloc] initWithFrame:CGRectMake(60, 5, 150, 15)];
        costumeName.text = @"Costume";
        costumeName.textColor = [UIColor whiteColor];
        [self addSubview:costumeName];
        
        buff = [[CustomLabelFont alloc] initWithFrame:CGRectMake(60, 20, 150, 15)];
        buff.text = @"spd +100%";
        buff.textColor = [UIColor greenColor];
        [self addSubview:buff];
        
        cost = [[CustomLabelFont alloc] initWithFrame:CGRectMake(80, 36, 150, 15)];
        cost.text = @"100";
        cost.textColor = [UIColor grayColor];
        [self addSubview:cost];
        
        costIcon = [[UIImageView alloc] initWithFrame:CGRectMake(60, 36, 15, 15)];
        costIcon.image = [UIImage imageNamed:@"HudCakeIndicator.png"];
        [self addSubview:costIcon];
        
        equipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [equipButton setFrame:CGRectMake(220, 10, 75, 40)];
        [equipButton setTitle:@"BUY" forState:UIControlStateNormal];
        [equipButton.titleLabel setFont:[UIFont fontWithName:@"Vanilla" size:14]];
        [equipButton setTitleColor:[UIColor colorWithRed:0.48f green:0.36f blue:0.23f alpha:1] forState:UIControlStateNormal];
        [equipButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
        [self addSubview:equipButton];
        
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
