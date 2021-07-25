//
//  DDPartyDetailsViewController.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/25.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyListViewController.h"
#import "DDPartyDetailsViewController.h"
#import "DDWebViewController.h"
#import "UIScrollView+DREmptyDataSet.h"
#import "DDPartyContentCollectionViewCell.h"
#import "DDPartyBLL.h"
#import "DDPartyModel.h"
#import "DDWebManager.h"
#import "DDPreviewManage.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import "UIViewController+RotationControl.h"
@interface DDPartyListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic, strong) SJVideoPlayer *player;

@end

@implementation DDPartyListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _page = 1;
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;

    [self loadSubViews];

    [self refreshList];
}

- (void)refreshList {
 
   YXWeakSelf;
   self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       weakSelf.page = 1;
       [weakSelf loadData];
   }];
   self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       weakSelf.page ++ ;
       [weakSelf loadData];
   }];
}


- (void)loadData {
    
    if (self.type == PartyListStateHome) {
        NSString *sign;
        NSString *isRecommend;
        NSString *newTypeId;
        if (self.sign.length > 0 ) {
            sign = self.sign;
            if ([self.sign isEqualToString:@"2"]) {
                isRecommend = @"1";
            }else {
                isRecommend = @"";
            }
        }else {
            sign = @"2";
            isRecommend = nil;
            newTypeId = self.typeModel.ID;
        }
        
        YXWeakSelf
        [YJProgressHUD showLoading:@""];
        [[DDPartyBLL sharedPartyBLL] queryIndexDataListWithSign:sign isRecommend:isRecommend newTypeId:newTypeId pageIndex:@(self.page).stringValue pageSize:@"10" onDatListSuccess:^(NSArray * _Nonnull listArr) {
            [YJProgressHUD hideHUD];
            if (weakSelf.page == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            NSArray *tem = [DDPartyModel mj_objectArrayWithKeyValuesArray:listArr];
            [weakSelf.dataArr addObjectsFromArray:tem];
            if ([tem count] < 10) {
                [weakSelf.collectionView.mj_footer setHidden:YES];
            }else{
                [weakSelf.collectionView.mj_footer setHidden:NO];
            }
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView reloadData];
        } bllFailed:^(NSString * _Nonnull msg) {
            [YJProgressHUD hideHUD];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
        } onNetWorkFail:^(NSString * _Nonnull msg) {
            [YJProgressHUD hideHUD];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
        } onRequestTimeOut:^{
            [YJProgressHUD hideHUD];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }else if (self.type == PartyListStateLearn) {
         YXWeakSelf
        [YJProgressHUD showLoading:@""];
        [[DDPartyBLL sharedPartyBLL] queryTwoStudyDataListWithSign:self.sign pageIndex:@(self.page).stringValue pageSize:@"10" onDataListSuccess:^(NSArray * _Nonnull listArr) {
            [YJProgressHUD hideHUD];
            if (weakSelf.page == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            NSArray *tem = [DDPartyModel mj_objectArrayWithKeyValuesArray:listArr];
            [weakSelf.dataArr addObjectsFromArray:tem];
            if ([tem count] < 10) {
                [weakSelf.collectionView.mj_footer setHidden:YES];
            }else{
                [weakSelf.collectionView.mj_footer setHidden:NO];
            }
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView reloadData];
        } bllFailed:^(NSString * _Nonnull msg) {
            [YJProgressHUD hideHUD];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
        } onNetWorkFail:^(NSString * _Nonnull msg) {
            [YJProgressHUD hideHUD];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
        } onRequestTimeOut:^{
            [YJProgressHUD hideHUD];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
        
    }
    
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    DDPartyModel *partyModel = self.dataArr[indexPath.row];
    DDPartyEntityModel *entityModel = partyModel.entityModel;
    if (entityModel.relType1 == 1) {
        if (partyModel.attachmentList.count == 0) {
            return CGSizeMake(KWIDTH, 110);
        }else if (partyModel.attachmentList.count == 1) {
            return CGSizeMake(KWIDTH, 110);
        }else if (partyModel.attachmentList.count > 1) {
            return CGSizeMake(KWIDTH, 110);
        }
    }else if (entityModel.relType1 == 2) {
        return CGSizeMake(KWIDTH, 272);
    }else if (entityModel.relType1 == 3){
        return CGSizeMake(KWIDTH, 318);
    }
   
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 10, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDPartyContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyContentCollectionViewCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.collectionView = collectionView;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DDPartyModel *partyModel = self.dataArr[indexPath.row];
    if (partyModel.entityModel.relType1 == 1) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *url= @"";
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Party_Graphic];
        [dic setValue:partyModel.entityModel.ID forKey:@"id"];
        if (self.type == PartyListStateLearn) {
            [dic setValue:@"2" forKey:@"sign"];
        }
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        DDWebViewController *webVC = [[DDWebViewController alloc] init];
        webVC.url = url;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (partyModel.entityModel.relType1 == 2) {
        NSMutableArray *imgArr = [NSMutableArray array];
        NSMutableArray *imgTitleArr = [NSMutableArray array];
        if (partyModel.attachmentList.count > 0) {
            for (DDPartyListModel *listModel in partyModel.attachmentList) {
                NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.filePath];
                [imgArr addObject:url];
                [imgTitleArr addObject:listModel.remark?listModel.remark:@""];
            }
            [[DDPreviewManage sharePreviewManage] showPhotoWithImgArr:imgArr imgTitleArr:imgTitleArr currentIndex:0];
        }
        
    }else if (partyModel.entityModel.relType1 == 3) {
        DDPartyDetailsViewController *vc = [[DDPartyDetailsViewController alloc] init];
        vc.partyMode = partyModel;
        [self.navigationController pushViewController:vc animated:YES];
    }


}


#pragma mark - Lazy Loading
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        YXWeakSelf
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
               _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
           }else{
               self.automaticallyAdjustsScrollViewInsets = NO;
           }
        [_collectionView registerClass:[DDPartyContentCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyContentCollectionViewCell"];
        [_collectionView setupEmptyDataText:@"暂无数据" tapBlock:^{
            weakSelf.page = 1;
            [weakSelf refreshList];
        }];

    }
    return _collectionView;
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

- (UIView *)listView {
    return self.view;
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
