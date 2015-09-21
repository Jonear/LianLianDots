//
//  LLDGameLevel.m
//  LianLianDots
//
//  Created by Jonear on 15/4/9.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDGameLevel.h"

@implementation LLDGameLevel

+ (id)modelWithBase:(LLDPlayBaseModel)base baseNum:(int)baseNum win:(LLDPlayWinModel)win winnum:(int)winNum tip:(NSString *)tip {
    LLDGameLevel *model = [[LLDGameLevel alloc] init];
    model.basemodel = base;
    model.basemodelnum = baseNum;
    model.winmodel = win;
    model.winmodelnum = winNum;
    model.tipMsg = tip;
    model.dotCount = 4;
    
    return model;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
