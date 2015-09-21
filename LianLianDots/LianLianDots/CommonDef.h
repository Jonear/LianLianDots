//
//  CommonDef.h
//  KwSing
//
//  Created by zg.shao on 14-7-17.
//  Copyright (c) 2014年 kuwo.cn. All rights reserved.
//

#ifndef KwSing_CommonDef_h
#define KwSing_CommonDef_h

// 设备的高和宽
#define     SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define     SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

#define     SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define     SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA   ([[UIScreen mainScreen] scale] >= 2.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_GREATER_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH >= 568.0)

#define ADJUST_SCREEN_WIDTH_SCALE (1 / (CGFloat)320 * SCREEN_WIDTH) // 适配屏幕宽度的比例系数

// 状态栏的高度
#define     STATUS_BAR_HEIGHT  20 //([UIApplication sharedApplication].statusBarFrame.size.height)


// 左边栏的宽度
#define     LEFT_VIEW_WIDTH  (SCREEN_WIDTH*47/64)

// 所有的导航栏的高度, 这是把状态栏算在内的
#define     NAVIGATION_BAR_HEIGHT   (44.0f + STATUS_BAR_HEIGHT)

// 首页上面的tabbar高度
#define     MAIN_TAB_BAR_HEIGHT     50
// BaseViewController中的tab bar的高度
#define     BASE_TAB_BAR_HEIGHT     48

#define DEFAULAVATAR [UIImage imageFromCacheWithName:@"defaultAvatar"]
#define DEFAULTIMAGE [UIImage imageFromCacheWithName:@"defaultImage"]
#define DEFAULMusicAvatar [UIImage imageFromCacheWithName:@"musiccrop_musiclist_default_Cover"]

// 默认作品的正方形光碟图片
#define DEFAULT_OPUS_IMAGE [UIImage imageFromCacheWithName:@"s_hotwork_threeItem_default"]


// 财富等级和人气等级 小图标的大小
#define LEVEL_IMAGE_SMALL_SIZE  CGSizeMake(15, 15)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO_IOS8                 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

// 三种对齐方式，重载控件的时候用
typedef enum KSAlignment {
    KSAlignmentLeft,
    KSAlignmentCenter,
    KSAlignmentRight
} KSAlignment;

// 当前app版本号
#define APP_VERSION_STRING [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]   // 发布版本

// 安全释放C++对象
#define SAFE_DELETE(p) { delete (p); (p) = NULL; }

//16进制颜色转换
#define COLOR_WITH_RGB(rgb) COLOR_WITH_RGBA(rgb, 1)

#define COLOR_WITH_RGBA(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgb & 0xFF00) >> 8)) / 255.0 \
blue:((float)((rgb & 0xFF))) / 255.0 \
alpha:a]

#endif
