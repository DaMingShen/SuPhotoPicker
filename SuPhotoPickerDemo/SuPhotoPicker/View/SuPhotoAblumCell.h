//
//  SuPhotoAblumCell.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SuAblumInfo;
@interface SuPhotoAblumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ablumCover;
@property (weak, nonatomic) IBOutlet UILabel *ablumName;
@property (weak, nonatomic) IBOutlet UILabel *ablumCount;

+ (instancetype)cellForTableView:(UITableView *)tableView info:(SuAblumInfo *)info;

@end
