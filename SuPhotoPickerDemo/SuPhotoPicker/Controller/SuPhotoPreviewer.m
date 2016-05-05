//
//  SuPhotoPreviewPage.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/8.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoPreviewer.h"
#import "SuPhotoHeader.h"
#import "SuPhotoBrowserCell.h"

@interface SuPhotoPreviewer ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *sendCount;
@property (weak, nonatomic) IBOutlet UILabel *sizeCount;
@property (weak, nonatomic) IBOutlet UIButton *isOriginalBtn; //原图按钮

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) UIButton * selBtn;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation SuPhotoPreviewer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    if (self.previewPhotos) {
        self.dataSource = self.previewPhotos.copy;
    }else if (self.isPreviewSelectedPhotos) {
        self.dataSource = [SuPhotoCenter shareCenter].selectedPhotos.copy;
    }else {
        self.dataSource = [SuPhotoCenter shareCenter].allPhotos.copy;
    }

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(SCREEN_W, SCREEN_H);
    layout.minimumLineSpacing = 40.0;
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(-20, 0, SCREEN_W + 40, SCREEN_H) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SuPhotoBrowserCell" bundle:nil] forCellWithReuseIdentifier:@"headCell"];
    [self.view insertSubview:self.collectionView belowSubview:self.bottomView];
    
    if (self.navigationController.viewControllers.count < 2) {
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithFrame:CGRectMake(0, 0, 22, 22) Target:self Selector:@selector(dismissPreviewer) Image:@"SuBack.png" ImagePressed:@"SuBack.png"]];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    self.selBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 26, 26) Target:self Selector:@selector(selBtnAction:) Image:@"SuPhoto_circle" ImageSelected:@"SuPhoto_selected"];
    UIBarButtonItem * navSelItem = [[UIBarButtonItem alloc]initWithCustomView:self.selBtn];
    self.navigationItem.rightBarButtonItem = navSelItem;
    
    self.isOriginalBtn.selected = [SuPhotoCenter shareCenter].isOriginal;
    self.currentPage = [self.dataSource indexOfObject:self.selectedAsset];
    [self refreshSelBtnStatusWithCurrentPage:(int)self.currentPage];
    [self refreshCompleteBtnStatus];
    [self refreshTitle];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UI状态
- (void)refreshBottomHiddenStatus {
    self.bottomView.hidden = !self.bottomView.hidden;
    self.navigationController.navigationBarHidden = self.bottomView.hidden;
    [UIApplication sharedApplication].statusBarHidden = self.bottomView.hidden;
}

- (void)refreshSelBtnStatusWithCurrentPage:(int)page {
    self.selBtn.selected = [[SuPhotoCenter shareCenter].selectedPhotos containsObject:self.dataSource[page]];
    self.currentPage = page;
}

- (void)refreshTitle {
    [self setNavigationTitle:[NSString stringWithFormat:@"%ld / %ld", self.currentPage + 1, self.dataSource.count]];
}

- (void)refreshCompleteBtnStatus {
    if ([SuPhotoCenter shareCenter].selectedPhotos.count) {
        self.sendCount.text = [NSString stringWithFormat:@"完成(%ld)",[SuPhotoCenter shareCenter].selectedPhotos.count];
    }else {
        self.sendCount.text = @"完成";
    }
}


#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SuPhotoBrowserCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headCell" forIndexPath:indexPath];
    [[SuPhotoManager manager]fetchImageInAsset:self.dataSource[indexPath.row] size:CGSizeMake(cell.w, cell.h) isResize:NO completeBlock:^(UIImage *image, NSDictionary *info) {
        cell.imageIV.contentMode = UIViewContentModeScaleAspectFit;
        cell.imageIV.image = image;
    }];
    cell.selBtn.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [cell setImgTapBlock:^{
        [weakSelf refreshBottomHiddenStatus];
    }];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x / self.collectionView.w;
    [self refreshSelBtnStatusWithCurrentPage:currentPage];
    [self refreshTitle];
}


#pragma mark - 按钮
- (void)selBtnAction:(UIButton *)sender {
    if (sender.selected) {
        [[SuPhotoCenter shareCenter].selectedPhotos removeObject:self.dataSource[self.currentPage]];
    }else {
        if ([[SuPhotoCenter shareCenter] isReachMaxSelectedCount]) return;
        [sender startSelectedAnimation];
        [[SuPhotoCenter shareCenter].selectedPhotos addObject:self.dataSource[self.currentPage]];
    }
    sender.selected = !sender.selected;
    [self refreshCompleteBtnStatus];
}

//发送
- (IBAction)sendAction:(UIButton *)sender {
    //如果没有选中图片，则发送当前预览的图片
    if ([SuPhotoCenter shareCenter].selectedPhotos.count <= 0) [[SuPhotoCenter shareCenter].selectedPhotos addObject:self.dataSource[self.currentPage]];
    [[SuPhotoCenter shareCenter] endPick];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if (self.doneBlock) self.doneBlock();
}

//原图
- (IBAction)changeSizeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [SuPhotoCenter shareCenter].isOriginal = sender.selected;
}

- (void)dismissPreviewer {
    if (self.backBlock) self.backBlock();
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
