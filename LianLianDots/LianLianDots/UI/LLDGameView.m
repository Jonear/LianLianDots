//
//  LLDGameView.m
//  LianLianDots
//
//  Created by Jonear on 15/4/3.
//  Copyright (c) 2015年 Jonear. All rights reserved.
//

#import "LLDGameView.h"
#import "LLDItemView.h"
#import "LLDGameManager.h"

@implementation LLDGameView {
    float _itmeWidth;
    NSArray *_itemArray;
    NSMutableArray *_selectedItemArray;
    CAShapeLayer *_polygonalLineLayer;
    UIBezierPath *_polygonalLinePath;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:NO];
        
        _itmeWidth = self.width/9;
        _itemArray = [NSArray arrayWithObjects:[NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array],
                      [NSMutableArray array], nil];
        _selectedItemArray = [[NSMutableArray alloc] init];
        
        _polygonalLinePath = [UIBezierPath new];
        _polygonalLineLayer = [[CAShapeLayer alloc] init];
        _polygonalLineLayer.lineWidth = 3.0f;
        _polygonalLineLayer.strokeColor = [UIColor redColor].CGColor;
        _polygonalLineLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_polygonalLineLayer];
        
        [self performSelector:@selector(updateItems) withObject:nil afterDelay:0.3];
        UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:panRec];
    }
    return self;
}

- (void)reStartGame {
    for (NSMutableArray *itemArray in _itemArray) {
        [itemArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [itemArray removeAllObjects];
    }
    [self updateItems];
}

- (void)updateItems {
    int row = 0;
    for (NSMutableArray *itemArray in _itemArray) {
        for (int i=0; i<9; i++) {
            if (itemArray.count <= i) {
                int randomTop = random()%10-2;
                LLDItemView *item = [[LLDItemView alloc] initWithFrame:CGRectMake(row*_itmeWidth, -i*_itmeWidth-randomTop, _itmeWidth, _itmeWidth)];
                [item setUserInteractionEnabled:NO];
                [self addSubview:item];
                [itemArray addObject:item];
            }
        }
        [UIView animateWithDuration:0.3 animations:^{
            int i=8;
            for (LLDItemView *item in itemArray) {
                item.top = i*_itmeWidth;
                i--;
            }
        }];
        row ++;
    }
}

- (LLDItemView *)getItemAtPoint:(CGPoint)point {
    int row = point.x/_itmeWidth;
    if (_itemArray.count > row) {
        NSMutableArray *array = _itemArray[row];
        int index = 9-point.y/_itmeWidth;
        if (array.count > index) {
            LLDItemView *view = array[index];
            //判断点是否在圆形区域内
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.frame cornerRadius:view.width/3];
            if ([path containsPoint:point]) {
                return view;
            }
        }
    }
    return nil;
}

- (void)removeItemFromArray:(LLDItemView *)item {
    int row = item.center.x/_itmeWidth;
    if (_itemArray.count > row) {
        NSMutableArray *array = _itemArray[row];
        [array removeObject:item];
    }
}

-(void)pan:(UIPanGestureRecognizer *)rec
{
    if (rec.state == UIGestureRecognizerStateBegan) {

    }
    
    CGPoint touchPoint = [rec locationInView:self];
    [self checkPoint:touchPoint];
    
    if (rec.state == UIGestureRecognizerStateEnded) {
        [self checkSelectedItem];
        [self clearPath];
        [self updateItems];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (_selectedItemArray.count == 0) {
        CGPoint touchPoint = [touch locationInView:self];
        [self checkPoint:touchPoint];
    }
}

- (void)checkPoint:(CGPoint)touchPoint {
    LLDItemView *item = [self getItemAtPoint:touchPoint];
    if (item) {
        if (![self addSelectedNode:item]) {
            [self moveLineWithFingerPosition:touchPoint];
        }
    }else{
        [self moveLineWithFingerPosition:touchPoint];
    }
}

- (void)clearPath {
    [_selectedItemArray removeAllObjects];
    [_polygonalLinePath removeAllPoints];
    _polygonalLineLayer.path = _polygonalLinePath.CGPath;
}

- (void)checkSelectedItem {
    if (_selectedItemArray.count >= 3) {
        LLDItemViewStyle style = LLDItemViewStyleRed;
        for (LLDItemView *view in _selectedItemArray) {
            [view removeFromSuperviewWithScore:_selectedItemArray.count*10];
            [self removeItemFromArray:view];
            style = view.style;
        }
        [[LLDGameManager defaultManager] clearDotType:style count:_selectedItemArray.count];
        if (_delegate && [_delegate respondsToSelector:@selector(didFinishStep)]) {
            [_delegate didFinishStep];
        }
    }
}

-(BOOL)addSelectedNode:(LLDItemView *)nodeView {
    if ([_selectedItemArray containsObject:nodeView]) {
        if (_selectedItemArray.count > 1) {
            LLDItemView *lastItem = _selectedItemArray[_selectedItemArray.count-2];
            if (lastItem == nodeView) {
                [nodeView showTouch];
                [self removeLastItemPath];
            }
        }
    } else {
        if (_selectedItemArray.count > 0) {
            LLDItemView *lastItem = [_selectedItemArray lastObject];
            if ([self isNearBy:lastItem.center ceter:nodeView.center] && lastItem.style==nodeView.style) {
                [_selectedItemArray addObject:nodeView];
                [self addLineToNode:nodeView];
                return YES;
            }
        } else if (nodeView.style != LLDItemViewStyleGray) {
            [_selectedItemArray addObject:nodeView];
            [self addLineToNode:nodeView];
            return YES;
        }
    }
    return NO;
}

- (BOOL)isNearBy:(CGPoint)ceter1 ceter:(CGPoint)ceter2 {
    return (ABS(ceter1.x/_itmeWidth-ceter2.x/_itmeWidth)<=1 && ABS(ceter1.y/_itmeWidth-ceter2.y/_itmeWidth)<=1);
}

-(void)addLineToNode:(LLDItemView *)nodeView {
    
    [nodeView showTouch];
    if(_selectedItemArray.count == 1){
        
        //path move to start point
        CGPoint startPoint = nodeView.center;
        [_polygonalLinePath moveToPoint:startPoint];
        _polygonalLineLayer.path = _polygonalLinePath.CGPath;
        _polygonalLineLayer.strokeColor = nodeView.styleColor.CGColor;
        
    }else{
        
        //path add line to point
        [_polygonalLinePath removeAllPoints];
        CGPoint startPoint = [_selectedItemArray[0] center];
        [_polygonalLinePath moveToPoint:startPoint];
        
        for (int i = 1; i < _selectedItemArray.count; ++i) {
            CGPoint middlePoint = [_selectedItemArray[i] center];
            [_polygonalLinePath addLineToPoint:middlePoint];
        }
        _polygonalLineLayer.path = _polygonalLinePath.CGPath;
        
    }
    
}

-(void)moveLineWithFingerPosition:(CGPoint)touchPoint
{
    if (_selectedItemArray.count > 0) {
        [_polygonalLinePath removeAllPoints];
        CGPoint startPoint = [_selectedItemArray[0] center];
        [_polygonalLinePath moveToPoint:startPoint];
        
        for (int i = 1; i < _selectedItemArray.count; ++i) {
            CGPoint middlePoint = [_selectedItemArray[i] center];
            [_polygonalLinePath addLineToPoint:middlePoint];
        }
        [_polygonalLinePath addLineToPoint:touchPoint];
        _polygonalLineLayer.path = _polygonalLinePath.CGPath;
    }
}

- (void)removeLastItemPath {
    [_selectedItemArray removeLastObject];
}

@end
