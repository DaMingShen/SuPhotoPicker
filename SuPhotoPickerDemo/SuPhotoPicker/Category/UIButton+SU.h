//
//  UIButton+SuExt.h
//  SuUtility
//
//  Created by KevinSu on 15/10/17.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SU)

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

+ (UIButton *)buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImagePressed:(NSString *)imagePressed;

+ (UIButton *)buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString *)imageSelected;

@end
