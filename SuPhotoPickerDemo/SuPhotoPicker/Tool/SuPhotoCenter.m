//
//  SuPhotoCenter.m
//  SuPhotoPickerDemo
//
//  Created by 万众科技 on 16/5/3.
//  Copyright © 2016年 KevinSu. All rights reserved.
//

#import "SuPhotoCenter.h"
#import "SuPhotoHeader.h"

@interface SuPhotoCenter () <PHPhotoLibraryChangeObserver, UIAlertViewDelegate>

@end

@implementation SuPhotoCenter

+ (instancetype)shareCenter {
    static SuPhotoCenter * center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[SuPhotoCenter alloc]init];
        center.selectedPhotos = [NSMutableArray array];
    });
    return center;
}

#pragma mark - 获取所有图片
- (void)fetchAllAsset {
    [self clearInfos];
    [[PHPhotoLibrary sharedPhotoLibrary]registerChangeObserver:self];
    [self photoLibaryAuthorizationValid];
}

- (void)reloadPhotos {
    self.allPhotos = [[SuPhotoManager manager]fetchAllAssets];
    [[NSNotificationCenter defaultCenter] postNotificationName:PhotoLibraryChangeNotification object:nil];
}

#pragma mark - 完成图片选择
- (void)endPickWithImage:(UIImage *)cameraPhoto {
    if (self.handle) self.handle(@[cameraPhoto]);
}

- (void)endPick {
    if (self.handle) {
        [[SuPhotoManager manager]fetchImagesWithAssetsArray:self.selectedPhotos isOriginal:self.isOriginal completeBlock:^(NSArray *images) {
            self.handle(images);
        }];
    }
}

- (BOOL)isReachMaxSelectedCount {
    if (self.selectedPhotos.count >= self.selectedCount) {
        NSString * msg = [NSString stringWithFormat:@"最多只能选择%ld张", self.selectedCount];
        ShowMsg(msg);
        return YES;
    }
    return NO;
}

#pragma mark - 清除信息
- (void)clearInfos {
    self.selectedCount = 20;
    self.isOriginal = NO;
    self.handle = nil;
    self.allPhotos = nil;
    [self.selectedPhotos removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听图片变化代理
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    //此代理方法里的线程非主线程
    [self reloadPhotos];
}

#pragma mark - 权限验证
- (void)photoLibaryAuthorizationValid {
    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
    if (authoriation == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //这里非主线程，选择完成后会出发相册变化代理方法
        }];
    }else if (authoriation == PHAuthorizationStatusAuthorized) {
        [self reloadPhotos];
    }else {
        UIAlertView * photoLibaryNotice = [[UIAlertView alloc]initWithTitle:@"不能预览图片" message:@"应用程序无访问照片权限, 请在“设置\"-\"隐私\"-\"照片”中设置允许访问" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"设置", nil];
        [photoLibaryNotice show];
    }
}

- (void)cameraAuthoriationValidWithHandle:(void(^)())handle {
    AVAuthorizationStatus authoriation = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authoriation == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (handle) handle();
                });
            }
        }];
    }else if (authoriation == AVAuthorizationStatusAuthorized) {
        if (handle) handle();
    }else {
        UIAlertView * cameraNotice = [[UIAlertView alloc]initWithTitle:@"应用程序无访问相机权限" message:@"请在“设置\"-\"隐私\"-\"相机”中设置允许访问" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"设置", nil];
        [cameraNotice show];
    }
}

#pragma mark - AlertView代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        NSURL * setting = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:setting]) {
            [[UIApplication sharedApplication]openURL:setting];
        }
    }
}

@end
