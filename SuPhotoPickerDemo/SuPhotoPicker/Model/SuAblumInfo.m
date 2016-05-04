//
//  SuAblumInfo.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import "SuAblumInfo.h"

@implementation SuAblumInfo

+ (instancetype)infoFromResult:(PHFetchResult *)result collection:(PHAssetCollection *)collection {
    SuAblumInfo * ablumInfo = [[SuAblumInfo alloc]init];
    ablumInfo.ablumName = collection.localizedTitle;
    ablumInfo.count = result.count;
    ablumInfo.coverAsset = result[0];
    ablumInfo.assetCollection = collection;
    return ablumInfo;
}

@end
