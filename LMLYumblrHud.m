//
//  LMLYumblrHud.m
//  自定义活动指示器
//
//  Created by rimi on 15/9/1.
//  Copyright (c) 2015年 廖马林. All rights reserved.
//

#import "LMLYumblrHud.h"

@interface LMLYumblrHud ()
{
    NSMutableArray *hudRects;  // rect数组  这儿的话，hudRects == nil
}

@end

@implementation LMLYumblrHud

- (instancetype)init {

    self = [super init];
    return self;
}


#pragma mark - interface methods

- (void)showWithView:(UIView *)view color:(UIColor *)color {

    self.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    
    [self configUIWithView:(UIView *)view AndColor:color];
    [view addSubview:self];
    
}

- (void)stop {

    if ([self superview]) {
        
        [self removeFromSuperview];
    }
}

#pragma mark - private methods

- (void)configUIWithView:(UIView *)view AndColor:(UIColor *)color {

    self.backgroundColor = [UIColor clearColor];
    
    /* 添加一个半透明的黑色为背景 */
    UIView *translucence = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    translucence.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [self addSubview:translucence];
    
    /* 三个活动的小方块 */
    UIView *firstRect  = [self drawRectAtPosition:CGPointMake(0, 0) withColor:(UIColor *)color];
    CGPoint firstCenter = CGPointMake(view.center.x - 20, view.center.y - 50);
    firstRect.center = firstCenter;
    UIView *secondRect = [self drawRectAtPosition:CGPointMake(20, 0) withColor:(UIColor *)color];
    CGPoint secondCenter = CGPointMake(view.center.x, view.center.y - 50);
    secondRect.center = secondCenter;
    UIView *thirdRect  = [self drawRectAtPosition:CGPointMake(40, 0) withColor:(UIColor *)color];
    CGPoint thirdCenter = CGPointMake(view.center.x + 20, view.center.y - 50);
    thirdRect.center = thirdCenter;
    
    [self addSubview:firstRect];
    [self addSubview:secondRect];
    [self addSubview:thirdRect];
    
    [self doAnimateCyclyWithRects:hudRects];
}

- (UIView *)drawRectAtPosition:(CGPoint)position withColor:(UIColor *)color{
    
    UIView *rect = [[UIView alloc] init];
    CGRect rectFrame;
    rectFrame.size.width = 15;
    rectFrame.size.height = 16.5;
    rectFrame.origin.x = position.x;
    rectFrame.origin.y = 0;
    rect.frame = rectFrame;
    rect.backgroundColor = color;
    rect.alpha = 0.5;
    rect.layer.cornerRadius = 3;
    
    if (hudRects == nil) {
        
        hudRects = [NSMutableArray array];
    }
    
    [hudRects addObject:rect];
    
    return rect;
    
}



- (void)doAnimateCyclyWithRects:(NSMutableArray *)rects {

    //__weak typeof(self) wSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self animateRect:rects[0] withDuration:0.25];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self animateRect:rects[1] withDuration:0.2];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self animateRect:rects[2] withDuration:0.15];
            });
        });
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self doAnimateCyclyWithRects:rects];
    });
    
}


- (void)animateRect:(UIView *)rect withDuration:(NSTimeInterval)timeInterval {

    [rect setAutoresizingMask:UIViewAutoresizingFlexibleHeight];  // 自动调整自己的高度，保证与superView顶部和底部的距离不变。
    
    [UIView animateWithDuration:timeInterval animations:^{
        
        rect.alpha = 1;
        rect.transform = CGAffineTransformMakeScale(1, 1.3);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:timeInterval animations:^{
            
            rect.alpha = 0.5;
            rect.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
            // do nothing
        }];
    }];
    
}

@end
