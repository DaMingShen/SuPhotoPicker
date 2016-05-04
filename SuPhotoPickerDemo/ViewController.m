//
//  ViewController.m
//  SuPhotoPickerDemo
//
//  Created by KevinSu on 15/12/22.
//  Copyright © 2015年 KevinSu. All rights reserved.
//

#import "ViewController.h"
#import "SuPhotoPicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)choosePhoto:(id)sender {
    __weak typeof(self) weakSelf = self;
    SuPhotoPicker * picker = [[SuPhotoPicker alloc]init];
//    picker.selectedCount = 12;
//    picker.preViewCount = 2;
    [picker showInSender:self handle:^(NSArray<UIImage *> *photos) {
        [weakSelf showSelectedPhotos:photos];
    }];
}

- (void)showSelectedPhotos:(NSArray *)imgs {
    for (int i = 0; i < imgs.count; i ++) {
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(50 * i, 200, 50, 50)];
        iv.image = imgs[i];
        [self.view addSubview:iv];
    }
}


@end
