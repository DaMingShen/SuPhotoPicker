//
//  SuPhotoManager.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoManager.h"
#import "SuPhotoHeader.h"

#define OriginalRatio 0.9

@interface SuPhotoManager ()

@property (nonatomic ,strong) NSMutableArray<SuAblumInfo *> * ablumsList;

@end

@implementation SuPhotoManager


+ (instancetype)manager {
    
    static SuPhotoManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SuPhotoManager alloc]init];
        manager.ablumsList = [NSMutableArray array];
    });
    return manager;
}

/*
 * 获取所有相册
 */
- (NSArray<SuAblumInfo *> *)getAllAblums {
    
    //先清空数组
    [_ablumsList removeAllObjects];
    
    //列出并加入所有智能相册
    PHFetchResult * smartAblums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [self fetchCollection:smartAblums];
    
    //列出列出并加入所有用户创建的相册
    PHFetchResult * topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    [self fetchCollection:topLevelUserCollections];
    
    return _ablumsList;
}

/*
 * 获取相册资源
 */
- (void)fetchCollection:(PHFetchResult *)obj {
    
    //如果obj是所有相册的合集
    [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[PHAssetCollection class]]) {
            
            //返回此相册的资源集合
            PHFetchResult * result = [self fetchResultInCollection:obj asending:NO];
            
            //如果有资源
            if (result.count) {
                
                //创建此相册的信息集
                SuAblumInfo * info = [SuAblumInfo infoFromResult:result collection:obj];
                
                //加入到数组中
                [_ablumsList addObject:info];
            }
        }
    }];
}


/*
 * 获取（指定相册）或者（所有相册）资源的合集，并按资源的创建时间进行排序 YES  倒序 NO
 */
- (PHFetchResult *)fetchResultInCollection:(PHAssetCollection *)collection asending:(BOOL)asending {
    
    PHFetchOptions * option = [[PHFetchOptions alloc]init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:asending]];
//    option.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    PHFetchResult * result;
    //获取指定相册资源合集
    if (collection) {
        
        result = [PHAsset fetchAssetsInAssetCollection:collection options:option];
        
    }
    //获取所有相册资源合集
    else {
        
        result = [PHAsset fetchAssetsWithOptions:option];
    }
    return result;
}

/*
 * 获取所有相册图片资源
 */
- (NSArray<PHAsset *> *)fetchAllAssets {
    
    return [self fetchAssetsInCollection:nil asending:NO];
}

/*
 * 获取（指定相册）或者（所有相册 collection为nil）资源
 */
- (NSArray<PHAsset *> *)fetchAssetsInCollection:(PHAssetCollection *)collection asending:(BOOL)asending{
    
    NSMutableArray<PHAsset *> * list = [NSMutableArray array];
    
    PHFetchResult * result;
    
    //获取指定相册资源
    if (collection) {
        
        result = [self fetchResultInCollection:collection asending:asending];
    }
    //获取所有相册资源
    else {
        
        result = [self fetchResultInCollection:nil asending:asending];
        
    }
    
    //枚举添加到数组
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [list addObject:obj];
    }];
    
    return list;
}

/*
 * 获取资源对应的图片
 */
- (void)fetchImageInAsset:(PHAsset *)asset size:(CGSize)size isResize:(BOOL)isResize completeBlock:(void(^)(UIImage * image, NSDictionary * info))completeBlock {

    PHImageRequestOptions * option = [[PHImageRequestOptions alloc]init];
    //resizeMode：None，不缩放；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
    option.resizeMode = isResize ? PHImageRequestOptionsResizeModeFast : PHImageRequestOptionsResizeModeNone;

    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (completeBlock) completeBlock(result, info);
    }];
}

/*
 * 获取资源对应的原图大小
 */
- (void)getImageDataLength:(PHAsset *)asset completeBlock:(void(^)(CGFloat length))completeBlock{
    
    PHImageRequestOptions * option = [[PHImageRequestOptions alloc]init];
    option.resizeMode = PHImageRequestOptionsResizeModeNone;

    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        if (completeBlock) completeBlock(imageData.length / 1000.0);
    }];
}



- (void)fetchImagesWithAssetsArray:(NSMutableArray<PHAsset *> *)assetsArray isOriginal:(BOOL)isOriginal completeBlock:(void(^)(NSArray * images))completeBlock {
    
    NSMutableArray * images = [NSMutableArray array];

    for (int i = 0; i < assetsArray.count; i ++) {
        
        PHAsset * asset = assetsArray[i];
        CGSize size;
        
        if (isOriginal) {
            
            //源图 -> 不压缩
            size = CGSizeMake((CGFloat)asset.pixelWidth, (CGFloat)asset.pixelHeight);
            
        }else {
            
            //压缩的图 －> 以最长边为屏幕分辨率压缩
            CGFloat scale = (CGFloat)asset.pixelWidth / (CGFloat)asset.pixelHeight;
            if (scale > 1.0) {
                
                if (asset.pixelWidth < SCREEN_W) {
                    //最长边小于屏幕宽度时，采用原图
                    size = CGSizeMake((CGFloat)asset.pixelWidth, (CGFloat)asset.pixelHeight);
                }else {
                    //压缩
                    size = CGSizeMake(SCREEN_W, SCREEN_W / scale);
                }
                
            }else {
                
                if (asset.pixelHeight < SCREEN_H) {
                    //最长边小于屏幕高度时，采用原图
                    size = CGSizeMake((CGFloat)asset.pixelWidth, (CGFloat)asset.pixelHeight);
                }else {
                    //压缩
                    size = CGSizeMake(SCREEN_H * scale, SCREEN_H);
                }
                
            }
        }
        
        [self fetchImageInAsset:asset size:size isResize:YES completeBlock:^(UIImage *image, NSDictionary *info) {
            
            //当图片读取到指定尺寸时
            if (image.size.width >= size.width * OriginalRatio || image.size.height >= size.height * OriginalRatio) {

                [images addObject:image];
                
                //全部图片读取完毕
                if (images.count == assetsArray.count) {
                    
                    //执行block
                    if (completeBlock) completeBlock(images);
                }
            }
        }];
    }
    
}




@end
