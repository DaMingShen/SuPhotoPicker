//
//  NSString+SuAblum.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/7.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import "NSString+SU.h"

@implementation NSString (SU)

- (NSString *)chineseName {
    NSArray * engNameList = @[@"All Photos", @"Recently Added", @"Camera Roll", @"Videos", @"Favorites", @"Screenshots", @"Recently Deleted"];
    NSArray * chineseNameList = @[@"所有照片", @"最近添加", @"相机胶卷", @"视频", @"最爱", @"屏幕快照", @"最近删除"];
    if ([engNameList containsObject:self]) {
        NSInteger index = [engNameList indexOfObject:self];
        return chineseNameList[index];
    }
    return self;
}

@end
