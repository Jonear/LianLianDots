//
//  LLDTopBar.h
//  LianLianDots
//
//  Created by Jonear on 15/4/9.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLDTopBarDelegate;

@interface LLDTopBar : UIToolbar

@property (weak, nonatomic) id<LLDTopBarDelegate> topDelegate;

- (void)reloadLevelModel;

@end

@protocol LLDTopBarDelegate <NSObject>

- (void)backButtonClick;

@end
