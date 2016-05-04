//
//  SuAblumInfo.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface SuAblumInfo : NSObject

@property (nonatomic, copy) NSString * ablumName; //相册名字

@property (nonatomic, assign) NSInteger count; //总照片数

@property (nonatomic, strong) PHAssetCollection * assetCollection; //相册

@property (nonatomic, strong) PHAsset * coverAsset; //封面

+ (instancetype)infoFromResult:(PHFetchResult *)result collection:(PHAssetCollection *)collection;

@end
