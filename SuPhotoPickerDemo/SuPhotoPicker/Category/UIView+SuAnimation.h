//
//  UIView+SuAnimation.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SuAnimation)

/**
 *  从底部升起出现
 */
- (void)showFromBottom;

/**
 *  消失降到底部
 */
- (void)dismissToBottomWithCompleteBlock:(void(^)())completeBlock;

/**
 *  从透明到不透明
 */
- (void)emerge;

/**
 *  从不透明到透明
 */
- (void)fake;

/**
 *  按钮震动动画
 */
- (void)startSelectedAnimation;

@end
