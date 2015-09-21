//
//  LLDGameLevel.h
//  LianLianDots
//
//  Created by Jonear on 15/4/9.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LLDPlayBaseModel) {
    LLDPlayBaseModelTime,       //时间模式
    LLDPlayBaseModelStep,       //步数模式
};

typedef NS_ENUM(NSInteger, LLDPlayWinModel) {
    LLDPlayWinModelScore,       //分数
    LLDPlayWinModelRedDot,      //获得点
    LLDPlayWinModelBlueDot,     //获得点
    LLDPlayWinModelGreenDot,    //获得点
    LLDPlayWinModelPurpleDot,   //获得点
    LLDPlayWinModelGrayDot,     //获得点
    LLDPlayWinModelCrasy,       //疯狂模式
};

@interface LLDGameLevel : NSObject

@property (assign, nonatomic) LLDPlayBaseModel basemodel;       //基础模式
@property (assign, nonatomic) int              basemodelnum;    //模式量
@property (assign, nonatomic) LLDPlayWinModel  winmodel;        //获胜模式
@property (assign, nonatomic) int              winmodelnum;     //获胜模式l量
@property (assign, nonatomic) NSString        *tipMsg;          //关卡提示语
@property (assign, nonatomic) int              dotCount;        //关卡点的个数 默认4个

+ (id)modelWithBase:(LLDPlayBaseModel)base baseNum:(int)baseNum win:(LLDPlayWinModel)win winnum:(int)winNum tip:(NSString *)tip;

@end
