//
//  ViewController.m
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDMainViewController.h"
#import "LLDGameViewController.h"
#import "LLDItemView.h"
#import "LLDGameManager.h"

@interface LLDMainViewController ()

@end

@implementation LLDMainViewController {
    UILabel       *_titleLabel;
    UIScrollView  *_theScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSubViews {
    [self initLevelViewWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT)];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
    [_titleLabel setText:@"选择关卡"];
    [_titleLabel setFont:[UIFont systemFontOfSize:24]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor greenColor]];
    [self.view addSubview:_titleLabel];
}

- (void)initLevelViewWithFrame:(CGRect)frame {
    _theScrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    const CGFloat width = 50;
    
    int curLevel = [[LLDGameManager defaultManager] getCurrentLevel];
    for (int i = 0; i < 100; i ++) {
        float left = (width+10)*(i%5)+15;
        float top  = (width+10)*(i/5)+10;
        
        CGRect rect = CGRectMake(left, top, width, width);
        LLDItemView *btnItem;
        if (i == curLevel) {
            btnItem = [[LLDItemView alloc] initWithFrame:rect withStyle:LLDItemViewStyleRed];
        } else if (i > curLevel) {
             btnItem = [[LLDItemView alloc] initWithFrame:rect withStyle:LLDItemViewStyleGray];
        } else {
             btnItem = [[LLDItemView alloc] initWithFrame:rect withStyle:LLDItemViewStyleGreen];
        }
        
        [btnItem setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        [btnItem.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:15]];
        [btnItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnItem addTarget:self action:@selector(levelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_theScrollView addSubview:btnItem];
        
        if (i == 99) {
            [_theScrollView setContentSize:CGSizeMake(_theScrollView.width, btnItem.bottom+10)];
        }
    }

    [_theScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_theScrollView];
}

- (void)levelBtnClick:(UIButton*)sender {
    int curLevel = [[LLDGameManager defaultManager] getCurrentLevel]+1;
    if ([sender.titleLabel.text intValue] <= curLevel) {
        LLDGameViewController *gameViewController = [[LLDGameViewController alloc] init];
        [self presentViewController:gameViewController animated:NO completion:nil];
    }
}

@end
