//
//  FacebookVeiwController.h
//  FacebookTest
//
//  Created by martin magalong on 12/8/12.
//  Copyright (c) 2012 ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBviewControllerProtocol <NSObject>
@required
- (void)_didPost:(NSMutableDictionary *)param;
- (void)_didCancel;
@end
@interface FacebookVeiwController : UIViewController{
    NSMutableDictionary *_parameters;
    UITextView *_textView;
}
@property(nonatomic, assign) id<FBviewControllerProtocol>delegate;
@end
