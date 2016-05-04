//
//  SuMessageTool.m
//  SuPhotoPickerDemo
//
//  Created by KevinSu on 15/12/23.
//  Copyright © 2015年 KevinSu. All rights reserved.
//

#import "SuMessageTool.h"
#import "SuPhotoHeader.h"

@implementation SuMessageTool

/*
 * 显示提示信息
 */
- (void)ToastMessage:(NSString *)message {
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]}];
    CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));

    UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textSize.width + 30, textSize.height + 20)];
    msg.center = CGPointMake(SCREEN_W / 2, SCREEN_H * 8.0 / 9.0);
    msg.text = message;
    msg.font = [UIFont systemFontOfSize:15.0];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.backgroundColor = [UIColor blackColor];
    msg.textColor = [UIColor whiteColor];
    msg.layer.masksToBounds = YES;
    msg.layer.cornerRadius = (textSize.height + 20) / 2;
    [[UIApplication sharedApplication].keyWindow addSubview:msg];
    [UIView animateWithDuration:1.0 delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        msg.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismissMsg:) withObject:msg afterDelay:0.5];
    }];
}

- (void)dismissMsg:(UIView *)msg {
    [UIView animateWithDuration:0.3 animations:^{
        msg.alpha = 0.f;
    } completion:^(BOOL finished) {
        [msg removeFromSuperview];
    }];
}


@end
