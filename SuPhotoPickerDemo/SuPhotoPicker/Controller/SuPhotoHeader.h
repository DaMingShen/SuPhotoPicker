//
//  SuPhotoHeader.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/7.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#ifndef SuPhotoHeader_h
#define SuPhotoHeader_h

#define SCREEN_W    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H    ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_B    [[UIScreen mainScreen] bounds]

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define AblumsListLineColor RGBColor(192, 192, 192)
#define BGCOLOR  RGBColor(237, 238, 242)
#define BTNCOLOR RGBColor(38, 184, 243)
#define CLEARCOLOR [UIColor clearColor]
#define WHITECOLOR [UIColor whiteColor]
#define BLACKCOLOR [UIColor blackColor]

#define Space 5

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define ShowMsg(_msg) [[[SuMessageTool alloc]init]ToastMessage:_msg]

#define PhotoLibraryChangeNotification @"PhotoLibraryChangeNotification"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#import "SuPhotoCenter.h"
#import "SuPhotoAblumList.h"
#import "SuPhotoPreviewer.h"
#import "SuPhotoManager.h"

#import "UIView+SuAnimation.h"
#import "UIView+SuLine.h"
#import "UIView+SU.h"
#import "NSString+SU.h"
#import "UIButton+SU.h"
#import "UIImage+SU.h"
#import "SuMessageTool.h"

#endif /* SuPhotoHeader_h */













/*
 PHAsset: 代表照片库中的一个资源，跟 ALAsset 类似，通过 PHAsset 可以获取和保存资源
 PHFetchOptions: 获取资源时的参数，可以传 nil，即使用系统默认值
 PHFetchResult: 表示一系列的资源集合，也可以是相册的集合
 PHAssetCollection: 表示一个相册或者一个时刻，或者是一个「智能相册（系统提供的特定的一系列相册，例如：最近删除，视频列表，收藏等等，如下图所示）
 PHImageManager: 用于处理资源的加载，加载图片的过程带有缓存处理，可以通过传入一个 PHImageRequestOptions 控制资源的输出尺寸等规格
 PHImageRequestOptions: 如上面所说，控制加载图片时的一系列参数
 
 enum PHAssetCollectionType : Int {
 case Album //从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
 case SmartAlbum //经由相机得来的相册
 case Moment //Photos 为我们自动生成的时间分组的相册
 }
 
 enum PHAssetCollectionSubtype : Int {
 case AlbumRegular //用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
 case AlbumSyncedEvent //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。然而，在iTunes 12 以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
 case AlbumSyncedFaces //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
 case AlbumSyncedAlbum //做了 AlbumSyncedEvent 应该做的事
 case AlbumImported //从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。
 case AlbumMyPhotoStream //用户的 iCloud 照片流
 case AlbumCloudShared //用户使用 iCloud 共享的相册
 case SmartAlbumGeneric //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。由于本人的 iPhoto 已被 Photos 替代，无法验证。不过，在我的 iPad mini 上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
 case SmartAlbumPanoramas //相机拍摄的全景照片
 case SmartAlbumVideos //相机拍摄的视频
 case SmartAlbumFavorites //收藏文件夹
 case SmartAlbumTimelapses //延时视频文件夹，同时也会出现在视频文件夹中
 case SmartAlbumAllHidden //包含隐藏照片或视频的文件夹
 case SmartAlbumRecentlyAdded //相机近期拍摄的照片或视频
 case SmartAlbumBursts //连拍模式拍摄的照片，在 iPad mini 上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
 case SmartAlbumSlomoVideos //Slomo 是 slow motion 的缩写，高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。不过我的 iPad mini 不支持，没法验证。
 case SmartAlbumUserLibrary //这个命名最神奇了，就是相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
 case Any //包含所有类型
 }
 */