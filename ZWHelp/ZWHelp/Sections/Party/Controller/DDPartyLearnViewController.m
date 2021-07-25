//
//  DDPartyLearnViewController.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/17.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyLearnViewController.h"
#import "DDPartyListViewController.h"
#import "DDPartyDetailsViewController.h"
#import "DDWebViewController.h"

#import "DDPartyBannerCollectionViewCell.h"
#import "DDPartyLearnMenuCollectionViewCell.h"
#import "DDPartyContentCollectionViewCell.h"
#import "DDPartyHeaderView.h"

#import "DDPreviewManage.h"
#import "DDPartyModel.h"
#import "DDWebManager.h"
#import "DDPartyBLL.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import "UIViewController+RotationControl.h"
@interface DDPartyLearnViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic, strong) SJVideoPlayer *player;
@end

@implementation DDPartyLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"两学一做" Image:[UIImage imageNamed:@"navi_back_black"]];
    
    _page = 1;

    [self loadData];
    
    [self loadSubViews];
}

- (void)loadData {

    YXWeakSelf
    [YJProgressHUD showLoading:@""];
    [[DDPartyBLL sharedPartyBLL] queryTwoStudyDataListWithSign:@"3" pageIndex:@(_page).stringValue pageSize:@"3" onDataListSuccess:^(NSArray * _Nonnull listArr) {
        [YJProgressHUD hideHUD];
        weakSelf.dataArr  = [DDPartyModel mj_objectArrayWithKeyValuesArray:listArr];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
        [weakSelf.collectionView.mj_header endRefreshing];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
        [weakSelf.collectionView.mj_header endRefreshing];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
        [weakSelf.collectionView.mj_header endRefreshing];
    }];

}
- (void)viewDidLayoutSubviews {
    [self.collectionView.collectionViewLayout invalidateLayout];
}
- (void)loadSubViews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return self.dataArr.count;
    }
    return 0;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return CGSizeMake(KWIDTH, 200);
    }else if (indexPath.section == 1) {
        return CGSizeMake(KWIDTH / 2, 72);
    }else if (indexPath.section == 2 ) {
        DDPartyModel *partyModel = self.dataArr[indexPath.row];
        if (partyModel.attachmentList.count == 0) {
            return CGSizeMake(KWIDTH, 110);
        }else if (partyModel.attachmentList.count == 1) {
            return CGSizeMake(KWIDTH, 110);
        }else if (partyModel.attachmentList.count > 1) {
            return CGSizeMake(KWIDTH, 110);
        }
    }
    
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DDPartyBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyBannerCollectionViewCell" forIndexPath:indexPath];
        cell.type = 1;
        return cell;
    }else if (indexPath.section == 1) {
        DDPartyLearnMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyLearnMenuCollectionViewCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }else if (indexPath.section == 2) {
        DDPartyContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyContentCollectionViewCell" forIndexPath:indexPath];
        DDPartyModel *partyModel = self.dataArr[indexPath.row];
        cell.partyModel = partyModel;
        DDWeakSelf
        [cell setClickPlayBlock:^{
            if (partyModel.attachmentList.count > 0) {
                DDPartyListModel *listModel = partyModel.attachmentList[0];
                NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.filePath];
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [[DDPreviewManage sharePreviewManage] showVideoListWithUrl:url collectionView:weakSelf.collectionView IndexPath:indexPath player:weakSelf.player];
            }
        }];
        return cell;
    }
    
    return [UICollectionViewCell new];
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return CGSizeMake(KWIDTH, 50);
    }
    return CGSizeMake(KWIDTH, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 2) {
            DDPartyHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            header.indexPath = indexPath;
            header.titleLab.text = @"做合格党员";

            YXWeakSelf
            [header setClickMoreBtnBlock:^(NSIndexPath * _Nonnull indexPath) {
                if (indexPath.section == 2) {
                    DDPartyListViewController *vc = [DDPartyListViewController new];
                    vc.type = PartyListStateLearn;
                    vc.navigationItem.leftBarButtonItem = [weakSelf customBackItemWithTitle:@"做合格党员" Image:[UIImage imageNamed:@"navi_back_black"]];
                    vc.sign = @"3";
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            }];
            return header;
        }else {
            return nil;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        DDPartyListViewController *vc = [DDPartyListViewController new];
        vc.type = PartyListStateLearn;
        if (indexPath.row == 0) {
            vc.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"党章党规" Image:[UIImage imageNamed:@"navi_back_black"]];
            vc.sign = @"1";
        }else {
            vc.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"系列讲话" Image:[UIImage imageNamed:@"navi_back_black"]];
            vc.sign = @"2";
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 2) {
        DDPartyModel *partyModel = self.dataArr[indexPath.row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *url= @"";
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Party_Graphic];
        [dic setValue:partyModel.entityModel.ID forKey:@"id"];
        [dic setValue:@"2" forKey:@"sign"];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        DDWebViewController *webVC = [[DDWebViewController alloc] init];
        webVC.url = url;
        [self.navigationController pushViewController:webVC animated:YES];
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
        
        [_collectionView registerClass:[DDPartyBannerCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyBannerCollectionViewCell"];
        [_collectionView registerClass:[DDPartyLearnMenuCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyLearnMenuCollectionViewCell"];
        [_collectionView registerClass:[DDPartyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[DDPartyContentCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyContentCollectionViewCell"];
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            [weakSelf loadData];
        }];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (SJVideoPlayer *)player {
    if (!_player) {
        _player = [[SJVideoPlayer alloc] init];
    }
    return _player;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (BOOL)shouldAutorotate {
    return NO;
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
