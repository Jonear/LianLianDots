//
//  LLDItemView.m
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDItemView.h"

@implementation LLDItemView {
    UIView  *_tintView;
    UIView  *_backView;
    UILabel *_scoreLabel;
}

- (id)initWithFrame:(CGRect)frame {
    int style = random()%4;
    return [self initWithFrame:frame withStyle:style];
}

- (id)initWithFrame:(CGRect)frame withStyle:(LLDItemViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        if (style == LLDItemViewStyleRed) {
            _styleColor = COLOR_WITH_RGB(0xf283b2);
        } else if (style == LLDItemViewStyleBlue) {
            _styleColor = COLOR_WITH_RGB(0x5cc3f5);
        } else if (style == LLDItemViewStyleGreen) {
            _styleColor = COLOR_WITH_RGB(0x94cc8a);
        } else if (style == LLDItemViewStylePurple) {
            _styleColor = COLOR_WITH_RGB(0x8a68a4);
        } else if (style == LLDItemViewStyleGray) {
            _styleColor = [UIColor lightGrayColor];
        }
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    float size = self.width*3/5;
    _tintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    [_tintView setCenter:CGPointMake(self.width/2, self.height/2)];
    [_tintView setBackgroundColor:_styleColor];
    [_tintView.layer setCornerRadius:_tintView.width/2];
    [_tintView.layer setMasksToBounds:YES];
    [_tintView setUserInteractionEnabled:NO];
    [self addSubview:_tintView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    [_backView setCenter:CGPointMake(self.width/2, self.height/2)];
    [_backView setBackgroundColor:_styleColor];
    [_backView setAlpha:0.4];
    [_backView.layer setCornerRadius:_backView.width/2];
    [_backView.layer setMasksToBounds:YES];
    [_backView setUserInteractionEnabled:NO];
    [_backView setHidden:YES];
    [self insertSubview:_backView aboveSubview:_tintView];
    
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-20, self.width, 20)];
    [_scoreLabel setFont:[UIFont systemFontOfSize:17]];
    [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [_scoreLabel setTextColor:_styleColor];
    [_scoreLabel setHidden:YES];
    [self addSubview:_scoreLabel];
}

- (void)showTouch {
    [_backView setHidden:NO];
    [UIView animateWithDuration:0.5
                     animations:^{
                         _backView.transform = CGAffineTransformMakeScale(2.2, 2.2);
                     } completion:^(BOOL finished) {
                         [_backView setHidden:YES];
                         _backView.transform = CGAffineTransformMakeScale(1., 1.);
                     }];
}

- (void)removeFromSuperviewWithScore:(int)score {
    [_scoreLabel setHidden:NO];
    [_tintView setHidden:YES];
    [_scoreLabel setText:[NSString stringWithFormat:@"%d", score]];
    _scoreLabel.top = self.height-20;
    [UIView animateWithDuration:1
                     animations:^{
                         _scoreLabel.top = -self.top - 50;
                         _scoreLabel.left = (SCREEN_WIDTH-_scoreLabel.width)/2-self.left;
                     } completion:^(BOOL finished) {
                         [_scoreLabel setHidden:YES];
                         [self removeFromSuperview];
                     }];
}


@end
