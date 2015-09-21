//
//  LLDGameManager.m
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDGameManager.h"
#import "LLDGameLevel.h"

#define NSUDF_CurrentLevelKey  @"CurrentLevelKey"

@implementation LLDGameManager {
    int _currentLevel;
    LLDGameLevel *_curLevelModel;
    NSMutableArray *_levelArray;
}

+ (id)defaultManager {
    static LLDGameManager *gameMgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gameMgr = [[LLDGameManager alloc] init];
    });
    return gameMgr;
}

- (id)init {
    self = [super init];
    if (self) {
        _currentLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:NSUDF_CurrentLevelKey] integerValue];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveGame) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [self initLevelArray];
        [self reloadModel];
    }
    return self;
}

- (void)initLevelArray {
    _levelArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    // 1
    [_levelArray addObject:[LLDGameLevel modelWithBase:LLDPlayBaseModelStep baseNum:5 win:LLDPlayWinModelScore winnum:1000 tip:@"通过连接相同颜色在规定步数内获得指定分数！"]];
    [_levelArray addObject:[LLDGameLevel modelWithBase:LLDPlayBaseModelStep baseNum:8 win:LLDPlayWinModelScore winnum:2000 tip:@"通过连接相同颜色在规定步数内获得指定分数！"]];
    [_levelArray addObject:[LLDGameLevel modelWithBase:LLDPlayBaseModelStep baseNum:10 win:LLDPlayWinModelScore winnum:3000 tip:@"通过连接相同颜色在规定步数内获得指定分数！"]];
    [_levelArray addObject:[LLDGameLevel modelWithBase:LLDPlayBaseModelStep baseNum:15 win:LLDPlayWinModelScore winnum:4000 tip:@"通过连接相同颜色在规定步数内获得指定分数！"]];
    [_levelArray addObject:[LLDGameLevel modelWithBase:LLDPlayBaseModelStep baseNum:15 win:LLDPlayWinModelScore winnum:5000 tip:@"通过连接相同颜色在规定步数内获得指定分数！"]];
}

- (void)reloadModel {
    _curLevelModel = nil;
    if (_levelArray.count > _currentLevel) {
        _curLevelModel = _levelArray[_currentLevel];
    }
    
    _score = 0;
    _lostStep = _curLevelModel.basemodelnum;
}

- (int)getCurrentLevel {

    return _currentLevel;
}

- (LLDGameLevel*)getCurLevelModel {
    return _curLevelModel;
}

- (NSString *)getCurrentTip {
    return _curLevelModel.tipMsg;
}

- (BOOL)isWinTheGame {
    if (_curLevelModel.winmodel == LLDPlayWinModelScore) {
        if (_score >= _curLevelModel.winmodelnum) {
            _currentLevel ++;
            [self reloadModel];
            return YES;
        }
    }
    return NO;
}

- (BOOL)isGameOver {
    if (_lostStep <= 0) {
        return YES;
    }
    return NO;
}

- (void)clearDotType:(LLDItemViewStyle)type count:(int)count {
    _score += count*10*count;
    if (_curLevelModel.basemodel == LLDPlayBaseModelStep) {
        _lostStep --;
    }
}

- (void)saveGame {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_currentLevel] forKey:NSUDF_CurrentLevelKey];
    
}

@end
