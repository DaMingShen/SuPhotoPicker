//
//  UIImage+SU.h
//  SuPhotoPickerDemo
//
//  Created by 万众科技 on 16/5/3.
//  Copyright © 2016年 KevinSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SU)

//对图片尺寸进行压缩
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
