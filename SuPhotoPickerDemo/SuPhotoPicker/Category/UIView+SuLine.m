//
//  UIView+SuLine.m
//  SuPhotoPickerDemo
//
//  Created by KevinSu on 15/12/22.
//  Copyright © 2015年 KevinSu. All rights reserved.
//

#import "UIView+SuLine.h"
#import <UIKit/UIKit.h>

@implementation UIView (SuLine)

- (UIImageView *)findHairlineImageViewUnder {
    
    if ([self isKindOfClass:UIImageView.class] && self.bounds.size.height <= 1.0) {
        return (UIImageView *)self;
    }
    
    for (UIView * subview in self.subviews) {
        UIImageView * imageView = [subview findHairlineImageViewUnder];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
