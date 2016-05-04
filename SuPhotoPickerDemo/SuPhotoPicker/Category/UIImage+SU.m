//
//  UIImage+SU.m
//  SuPhotoPickerDemo
//
//  Created by 万众科技 on 16/5/3.
//  Copyright © 2016年 KevinSu. All rights reserved.
//

#import "UIImage+SU.h"

@implementation UIImage (SU)

//对图片尺寸进行压缩
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
