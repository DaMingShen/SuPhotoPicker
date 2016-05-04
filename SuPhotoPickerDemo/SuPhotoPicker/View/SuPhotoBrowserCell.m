//
//  SuPhotoBrowserCell.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoBrowserCell.h"

@implementation SuPhotoBrowserCell

- (IBAction)selectBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.selectedBlock) self.selectedBlock(sender.selected);
}

- (IBAction)imageTapAction:(UIButton *)sender {
    if (self.imgTapBlock) self.imgTapBlock();
}

@end
