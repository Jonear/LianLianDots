//
//  LLDGameManager.h
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLDItemView.h"

@class LLDGameLevel;

@interface LLDGameManager : NSObject

@property (assign, nonatomic) int score;        //已获得的分数
@property (assign, nonatomic) int lostStep;     //剩余的步数或时间

+ (LLDGameManager *)defaultManager;

- (int)getCurrentLevel;

- (NSString *)getCurrentTip;

- (BOOL)isWinTheGame;
- (BOOL)isGameOver;

- (LLDGameLevel *)getCurLevelModel;

- (void)clearDotType:(LLDItemViewStyle)type count:(int)count;

@end
