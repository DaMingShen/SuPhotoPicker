//
//  SuBaseViewController.m
//  NewsReader
//
//  Created by KevinSu on 15/10/15.
//  Copyright (c) 2015年 KevinSu. All rights reserved.
//

#import "SuPhotoBaseController.h"
#import "SuPhotoHeader.h"

@implementation SuPhotoBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavbar];
}

#pragma mark - 导航栏
- (void)setupNavbar {
    self.navigationController.navigationBar.barTintColor = BTNCOLOR;
    self.navigationController.navigationBar.tintColor = WHITECOLOR;
    //隐藏导航栏下面的线
    [self.navigationController.navigationBar findHairlineImageViewUnder].hidden = YES;
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithFrame:CGRectMake(0, 0, 22, 22) Target:self Selector:@selector(backBtnAction) Image:@"SuBack.png" ImagePressed:@"SuBack.png"]];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationTitle:(NSString *)title {
    self.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:WHITECOLOR}];
}

@end
