//
//  SuPhotoPicker.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuPhotoPicker : UIView

/*
 * 最大选择数,默认为20
 */
@property (nonatomic, assign) NSInteger selectedCount;

/*
 * 最大预览数,默认为20
 */
@property (nonatomic, assign) NSInteger preViewCount;

/**
 *  弹出图片选择器
 *
 *  @param sender
    sender:需要弹出图片选择器的VC
    sender:无tabbar传入当前VC
    sender:无tabbar且需要遮盖导航栏传入VC.navigationController
    sender:有tabbar需传入VC.tabbarController
 *
 *  @param handle 回调（图片数组）
 */
- (void)showInSender:(UIViewController *)sender handle:(void(^)(NSArray<UIImage *> * photos))handle;

@end
