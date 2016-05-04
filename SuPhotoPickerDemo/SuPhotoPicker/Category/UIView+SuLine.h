//
//  UIView+SuLine.h
//  SuPhotoPickerDemo
//
//  Created by KevinSu on 15/12/22.
//  Copyright © 2015年 KevinSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SuLine)

/*
 * 寻找1像素的线(可以用来隐藏导航栏下面的黑线）
 */
- (UIImageView *)findHairlineImageViewUnder;

@end
