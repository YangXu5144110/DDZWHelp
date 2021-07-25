//
//  DDPartyDetailsViewController.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyDetailsViewController.h"
#import "DDPartyDetailsHeaderCollectionViewCell.h"
#import "DDPartyDetailsContentCollectionViewCell.h"
#import "DDPartyDetailsFooterCollectionViewCell.h"

#import "DDPartyBLL.h"
#import "DDPartyModel.h"
#import "DDPreviewManage.h"
@interface DDPartyDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation DDPartyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"详情" Image:[UIImage imageNamed:@"navi_back_black"]];
        
    [self loadSubViews];
}

- (void)loadSubViews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.edges.offset(0);
        }
    }];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return CGSizeMake(KWIDTH, self.partyMode.entityModel.titleHeight + 37);
    }else if (indexPath.row == 1) {
        return CGSizeMake(KWIDTH, 220);
    }else if (indexPath.row == 2) {
        return CGSizeMake(KWIDTH, self.partyMode.entityModel.cellHeight + 15);
    }
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        DDPartyDetailsHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyDetailsHeaderCollectionViewCell" forIndexPath:indexPath];
         cell.partyModel = self.partyMode;
         return cell;
    }else if (indexPath.row == 1) {
        DDPartyDetailsContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyDetailsContentCollectionViewCell" forIndexPath:indexPath];
         cell.partyModel = self.partyMode;
         YXWeakSelf
        [cell setClickplayBtnBlock:^{
            [weakSelf showVideo];
        }];
         return cell;
    }else {
        DDPartyDetailsFooterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyDetailsFooterCollectionViewCell" forIndexPath:indexPath];
        cell.partyModel = self.partyMode;
        return cell;
    }
    return [UICollectionViewCell new];
}

- (void)showVideo {
    if (self.partyMode.attachmentList.count > 0) {
        DDPartyListModel *listModel = self.partyMode.attachmentList[0];
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.filePath];
        [[DDPreviewManage sharePreviewManage] showVideoWithUrl:url withController:self];
    }
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        DDWeakSelf
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[DDPartyDetailsHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyDetailsHeaderCollectionViewCell"];
        [_collectionView registerClass:[DDPartyDetailsContentCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyDetailsContentCollectionViewCell"];
        [_collectionView registerClass:[DDPartyDetailsFooterCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyDetailsFooterCollectionViewCell"];
    }
    return _collectionView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
