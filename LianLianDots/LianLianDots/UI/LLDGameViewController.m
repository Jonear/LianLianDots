//
//  LLDGameViewController.m
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDGameViewController.h"
#import "LLDGameView.h"
#import "LLDTopBar.h"
#import "LLDGameManager.h"

@interface LLDGameViewController () <LLDTopBarDelegate, LLDGameViewDelegate, UIAlertViewDelegate>

@end

@implementation LLDGameViewController {
    LLDGameView   *_gameView;
    LLDTopBar     *_topBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews {
    _topBar = [[LLDTopBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    _topBar.topDelegate = self;
    [self.view addSubview:_topBar];
    
    _gameView = [[LLDGameView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+20, SCREEN_WIDTH, SCREEN_WIDTH)];
    _gameView.delegate = self;
    [self.view addSubview:_gameView];
}

- (void)backButtonClick; {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didFinishStep {
    [_topBar reloadLevelModel];
    
    if ([[LLDGameManager defaultManager] isWinTheGame]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Win" message:@"成功获得胜利,是否进入下一关" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"下一关", nil];
        [alert show];
    } else if ([[LLDGameManager defaultManager] isWinTheGame]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败了" message:@"闯关失败，是否重新开始" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重新开始", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        [_topBar reloadLevelModel];
        [_gameView reStartGame];
    }
}

@end
