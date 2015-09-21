//
//  LLDItemView.h
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LLDItemViewStyle) {
    LLDItemViewStyleRed,
    LLDItemViewStyleBlue,
    LLDItemViewStyleGreen,
    LLDItemViewStylePurple,
    LLDItemViewStyleGray,
};

@interface LLDItemView : UIButton

@property (assign, nonatomic) CGPoint moveCenter;
@property (assign, nonatomic) LLDItemViewStyle style;
@property (strong, nonatomic) UIColor *styleColor;

- (id)initWithFrame:(CGRect)frame withStyle:(LLDItemViewStyle)style;
- (void)showTouch;
- (void)removeFromSuperviewWithScore:(int)score;

@end
