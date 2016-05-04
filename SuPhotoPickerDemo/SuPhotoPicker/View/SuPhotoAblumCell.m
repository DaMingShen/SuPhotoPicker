//
//  SuPhotoAblumCell.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoAblumCell.h"
#import "SuPhotoHeader.h"


@implementation SuPhotoAblumCell

+ (instancetype)cellForTableView:(UITableView *)tableView info:(SuAblumInfo *)info {
    //表格列表不多，不选择重用机制
    SuPhotoAblumCell * cell = [[NSBundle mainBundle]loadNibNamed:@"SuPhotoAblumCell" owner:tableView options:nil][0];
    [[SuPhotoManager manager]fetchImageInAsset:info.coverAsset size:CGSizeMake(120, 120) isResize:YES completeBlock:^(UIImage *image, NSDictionary *info) {
       
        cell.ablumCover.image = image;
    }];
    cell.ablumName.text = [info.ablumName chineseName];
    cell.ablumCount.text = [NSString stringWithFormat:@"(%ld)",info.count];
    
    //line
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(100, 61 - SINGLE_LINE_ADJUST_OFFSET, SCREEN_W - 100, SINGLE_LINE_WIDTH)];
    line.backgroundColor = AblumsListLineColor;
    [cell.contentView addSubview:line];
    
    //indicator
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
