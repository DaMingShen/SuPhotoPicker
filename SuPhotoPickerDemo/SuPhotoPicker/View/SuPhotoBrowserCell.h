//
//  SuPhotoBrowserCell.h
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuPhotoBrowserCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *selBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;

@property (nonatomic, copy) void(^selectedBlock)(BOOL isSelected);
@property (nonatomic, copy) void(^imgTapBlock)();

@end
