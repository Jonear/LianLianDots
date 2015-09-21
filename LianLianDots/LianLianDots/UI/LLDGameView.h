//
//  LLDGameView.h
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLDGameViewDelegate;

@interface LLDGameView : UIView

@property (weak, nonatomic) id<LLDGameViewDelegate> delegate;

- (void)updateItems;
- (void)reStartGame;

@end

@protocol LLDGameViewDelegate <NSObject>

- (void)didFinishStep;

@end
