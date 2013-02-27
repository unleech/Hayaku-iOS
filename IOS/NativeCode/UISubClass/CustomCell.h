//
//  CustomCell.h
//  Unity-iPhone
//
//  Created by Jan Michael on 2/26/13.
//
//

#import <UIKit/UIKit.h>
#import "CustomLabelFont.h"

@interface CustomCell : UITableViewCell

@property (nonatomic, retain)    UIImageView     *portrait;
@property (nonatomic, retain)    CustomLabelFont *buff;
@property (nonatomic, retain)    CustomLabelFont *costumeName;
@property (nonatomic, retain)    CustomLabelFont *cost;
@property (nonatomic, retain)    UIImageView     *costIcon;
@property (nonatomic, retain)    UIButton        *equipButton;


- (id)initWithStyleCS:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTableWidth:(float)width withRowHeight:(float)rowHeight;

@end
