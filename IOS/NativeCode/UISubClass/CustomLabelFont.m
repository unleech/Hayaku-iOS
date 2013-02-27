//
//  CustomLabelFont.m
//  Unity-iPhone
//
//  Created by Jan Michael on 2/27/13.
//
//

#import "CustomLabelFont.h"

@implementation CustomLabelFont

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.font = [UIFont fontWithName:@"Visitor TT1 BRK" size:14];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
