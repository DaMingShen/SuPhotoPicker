//
//  SuPhotoCenter.h
//  SuPhotoPickerDemo
//
//  Created by 万众科技 on 16/5/3.
//  Copyright © 2016年 KevinSu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@interface SuPhotoCenter : NSObject

/*
 * 最大选择数,默认为20
 */
@property (nonatomic, assign) NSInteger selectedCount;

/*
 * 是否原图
 */
@property (nonatomic, assign) BOOL isOriginal;

/**
 *  所有的图片
 */
@property (nonatomic, strong) NSArray * allPhotos;

/**
 *  选择的图片
 */
@property (nonatomic, strong) NSMutableArray * selectedPhotos;

/**
 *  选择完毕回调
 */
@property (nonatomic, copy) void(^handle)(NSArray<UIImage *> * photos);

/**
 *  单例
 */
+ (instancetype)shareCenter;

/**
 *  获取所有照片
 */
- (void)fetchAllAsset;

/**
 *  获取相机权限
 */
- (void)cameraAuthoriationValidWithHandle:(void(^)())handle;

/**
 *  判断是否达到最大选择数
 */
- (BOOL)isReachMaxSelectedCount;

/**
 *  完成选择（相机的照片）
 */
- (void)endPickWithImage:(UIImage *)cameraPhoto;

/**
 *  完成选择（相册的照片）
 */
- (void)endPick;

/**
 *  清除信息
 */
- (void)clearInfos;

@end
