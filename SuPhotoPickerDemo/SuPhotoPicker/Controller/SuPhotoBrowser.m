//
//  SuPhotoBrowser.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright © 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoBrowser.h"
#import "SuPhotoHeader.h"
#import "SuPhotoBrowserCell.h"

@interface SuPhotoBrowser ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView; //底部面板
@property (weak, nonatomic) IBOutlet UIButton *isOriginalBtn; //原图按钮
@property (weak, nonatomic) IBOutlet UIView *bottomViewCover; //底部面板遮罩层
@property (weak, nonatomic) IBOutlet UILabel *comBtn; //完成按钮

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation SuPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:self.collectionTitle ? self.collectionTitle : @"相机胶卷"];
    [self setupUI];
    [self loadAssetData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshBottomView];
    [self.collectionView reloadData];
}

#pragma mark - UI
- (void)setupUI {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_W - 5 * 3) / 4, (SCREEN_W - 5 * 3) / 4);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 38) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SuPhotoBrowserCell" bundle:nil] forCellWithReuseIdentifier:@"browserCell"];
    [self.view insertSubview:self.collectionView belowSubview:self.bottomView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnAction)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)cancelBtnAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshBottomView {
    if ([SuPhotoCenter shareCenter].selectedPhotos.count > 0) {
        self.bottomViewCover.hidden = YES;
        self.isOriginalBtn.selected = [SuPhotoCenter shareCenter].isOriginal;
        self.comBtn.text = [NSString stringWithFormat:@"完成(%ld)",[SuPhotoCenter shareCenter].selectedPhotos.count];
    }else {
        self.bottomViewCover.hidden = NO;
        self.isOriginalBtn.selected = NO;
        self.comBtn.text = @"完成";
    }
}

#pragma mark - 数据
- (void)loadAssetData {
    self.dataSource = [[SuPhotoManager manager]fetchAssetsInCollection:self.assetCollection asending:NO];
}

#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SuPhotoBrowserCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"browserCell" forIndexPath:indexPath];
    [[SuPhotoManager manager]fetchImageInAsset:self.dataSource[indexPath.row] size:CGSizeMake(cell.w * 2, cell.h * 2) isResize:YES completeBlock:^(UIImage *image, NSDictionary *info) {
        cell.imageIV.image = image;
    }];
    cell.selBtn.selected = [[SuPhotoCenter shareCenter].selectedPhotos containsObject:self.dataSource[indexPath.row]];
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    [cell setSelectedBlock:^(BOOL isSelected) {
        if (isSelected) {
            if ([[SuPhotoCenter shareCenter] isReachMaxSelectedCount]) {
                weakCell.selBtn.selected = NO;
                return;
            }
            [weakCell.selBtn startSelectedAnimation];
            [[SuPhotoCenter shareCenter].selectedPhotos addObject:weakSelf.dataSource[indexPath.row]];
        }else {
            [[SuPhotoCenter shareCenter].selectedPhotos removeObject:weakSelf.dataSource[indexPath.row]];
        }
        [weakSelf refreshBottomView];
    }];
    [cell setImgTapBlock:^{
        SuPhotoPreviewer * previewer = [[SuPhotoPreviewer alloc]init];
        if (weakCell.selBtn.selected) {
            previewer.isPreviewSelectedPhotos = YES;
        }
        previewer.selectedAsset = weakSelf.dataSource[indexPath.row];
        [previewer setBackBlock:^(){
            [collectionView reloadData];
            [weakSelf refreshBottomView];
        }];
        [weakSelf.navigationController pushViewController:previewer animated:YES];
    }];
    return cell;
}


#pragma mark - 按钮
- (IBAction)senBtnAction:(UIButton *)sender {
    [[SuPhotoCenter shareCenter] endPick];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeSizeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [SuPhotoCenter shareCenter].isOriginal = sender.selected;
}

@end
