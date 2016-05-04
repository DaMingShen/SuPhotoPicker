//
//  SuPhotoPreviewPage.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/8.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoBaseController.h"

@class PHAsset;
@interface SuPhotoPreviewer : SuPhotoBaseController

@property (nonatomic, strong) PHAsset * selectedAsset; //初始显示的图片
@property (nonatomic, strong) NSArray * previewPhotos;
@property (nonatomic, assign) BOOL isPreviewSelectedPhotos;
@property (nonatomic, copy) void(^backBlock)();
@property (nonatomic, copy) void(^doneBlock)();

@end
