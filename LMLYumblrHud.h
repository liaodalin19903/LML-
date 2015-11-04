//
//  LMLYumblrHud.h
//  自定义活动指示器
//
//  Created by rimi on 15/9/1.
//  Copyright (c) 2015年 廖马林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMLYumblrHud : UIView

/**
 *  显示活动LML指示器
 *
 *  @param view  在这个view上面加载活动指示器
 *  @param color 活动指示器的颜色
 */
- (void)showWithView:(UIView *)view color:(UIColor *)color;
- (void)stop;

@end
