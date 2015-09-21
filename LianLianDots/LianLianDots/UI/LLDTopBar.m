//
//  LLDTopBar.m
//  LianLianDots
//
//  Created by Jonear on 15/4/9.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDTopBar.h"
#import "LLDGameManager.h"
#import "LLDGameLevel.h"

@implementation LLDTopBar {
    UILabel *_scoreLabel;
    UILabel *_stepLabel;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBarStyle:UIBarStyleBlackTranslucent];
        [self initSubViews];
        
        [self reloadLevelModel];
    }
    return self;
}

- (void)initSubViews {
    UIButton *backbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backbutton setImage:[UIImage imageNamed:@"backbutton_icon"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backbutton];
    
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, SCREEN_WIDTH-88, 44)];
    [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [_scoreLabel setTextColor:[UIColor whiteColor]];
    [_scoreLabel setFont:[UIFont systemFontOfSize:25]];
    [_scoreLabel setHidden:YES];
    [self addSubview:_scoreLabel];
    
    _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44, 20, 44, 44)];
    [_stepLabel setTextAlignment:NSTextAlignmentCenter];
    [_stepLabel setTextColor:[UIColor whiteColor]];
    [_stepLabel setFont:[UIFont systemFontOfSize:20]];
    [_stepLabel setHidden:YES];
    [self addSubview:_stepLabel];
}

- (void)backButtonClick:(id)sender {
    if (_topDelegate && [_topDelegate respondsToSelector:@selector(backButtonClick)]) {
        [_topDelegate backButtonClick];
    }
}

- (void)reloadLevelModel {
    LLDGameLevel *levelModel = [[LLDGameManager defaultManager] getCurLevelModel];
    if (levelModel) {
        if (levelModel.winmodel == LLDPlayWinModelScore) {
            [_scoreLabel setHidden:NO];
            [_scoreLabel setText:[NSString stringWithFormat:@"%d/%d", [[LLDGameManager defaultManager] score] ,levelModel.winmodelnum]];
        } else {
            
        }
        
        [_stepLabel setHidden:NO];
        [_stepLabel setText:[NSString stringWithFormat:@"%d", [[LLDGameManager defaultManager] lostStep]]];
    }
}

@end
