//
//  DDPartyTypeListViewController.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/15.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyTypeListViewController.h"
#import "DDPartyViewController.h"
#import "DDPartyListViewController.h"
#import "DDPartyDetailsViewController.h"
#import "DDPartyLearnViewController.h"
#import "DDWebViewController.h"

#import "DDPartyBannerCollectionViewCell.h"
#import "DDPartyMenuCollectionViewCell.h"
#import "DDPartyContentCollectionViewCell.h"
#import "DDPartyHeaderView.h"

#import "DDPreviewManage.h"
#import "DDWebManager.h"
#import "DDPartyBLL.h"
#import "DDPartyModel.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import "UIViewController+RotationControl.h"

@interface DDPartyTypeListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic, strong) SJVideoPlayer *player;
@end

@implementation DDPartyTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"党建" Image:[UIImage new]];
    
    _page = 1;

    [self loadData];
    
    [self loadSubViews];

}

- (void)loadData {

    YXWeakSelf
    __block NSMutableArray *partyArr = [NSMutableArray array];
    __block NSMutableArray *newsArr = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    [[DDPartyBLL sharedPartyBLL] queryIndexDataListWithSign:@"1" isRecommend:@"" newTypeId:nil pageIndex:@(_page).stringValue pageSize:@"3" onDatListSuccess:^(NSArray * _Nonnull listArr) {
        partyArr = [DDPartyModel mj_objectArrayWithKeyValuesArray:listArr];
        dispatch_group_leave(group);
    } bllFailed:^(NSString * _Nonnull msg) {
        [weakSelf.collectionView.mj_header endRefreshing];
        dispatch_group_leave(group);
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [weakSelf.collectionView.mj_header endRefreshing];
        dispatch_group_leave(group);
    } onRequestTimeOut:^{
        [weakSelf.collectionView.mj_header endRefreshing];
        dispatch_group_leave(group);
    }];
    
    
    dispatch_group_enter(group);
    [[DDPartyBLL sharedPartyBLL] queryIndexDataListWithSign:@"2" isRecommend:@"1" newTypeId:nil pageIndex:@(_page).stringValue pageSize:@"3" onDatListSuccess:^(NSArray * _Nonnull listArr) {
        newsArr = [DDPartyModel mj_objectArrayWithKeyValuesArray:listArr];
        dispatch_group_leave(group);
    } bllFailed:^(NSString * _Nonnull msg) {
        [weakSelf.collectionView.mj_header endRefreshing];
        dispatch_group_leave(group);
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [weakSelf.collectionView.mj_header endRefreshing];
        dispatch_group_leave(group);
    } onRequestTimeOut:^{
        [weakSelf.collectionView.mj_header endRefreshing];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.dataArr addObject:partyArr];
        [weakSelf.dataArr addObject:newsArr];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    });

}

// 判断是否是党员
- (void)queryIsParty {
    
    DDWeakSelf
    [[DDPartyBLL sharedPartyBLL] queryIsPartyOnIsPartySuccess:^(id  _Nonnull resultDic) {
        DDPartyLearnViewController *vc = [DDPartyLearnViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } bllFailed:^(NSString * _Nonnull msg) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_PartyRZ];
        NSString *url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        if (url.length > 0) {
            DDWebViewController *webVC = [[DDWebViewController alloc] init];
            webVC.url = url;
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        }
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        
    } onRequestTimeOut:^{
        
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
    return 2 + self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    }else if (section > 1) {
        NSArray *tem = self.dataArr[section-2];
        return tem.count;
    }
    return 0;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return CGSizeMake(KWIDTH, 200);
    }else if (indexPath.section == 1) {
        return CGSizeMake(KWIDTH / 4, 86);
    }else if (indexPath.section > 1 ) {
        NSArray *tem = self.dataArr[indexPath.section-2];
        if (tem.count > 0) {
            DDPartyModel *partyModel = tem[indexPath.row];
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
        }else {
            return CGSizeMake(KWIDTH, 0);
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
        cell.type = 0;
        return cell;
    }else if (indexPath.section == 1) {
        DDPartyMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyMenuCollectionViewCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }else if (indexPath.section  > 1) {
        DDPartyContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPartyContentCollectionViewCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.collectionView = collectionView;
        NSArray *tem = self.dataArr[indexPath.section-2];
        DDPartyModel *partyModel = tem[indexPath.row];
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
    
    if (section > 1) {
        return CGSizeMake(KWIDTH, 50);
    }
    return CGSizeMake(KWIDTH, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section > 1) {
            DDPartyHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            header.indexPath = indexPath;
            if (indexPath.section == 2) {
                header.titleLab.text = @"党务公开";
            }else if (indexPath.section == 3) {
                header.titleLab.text = @"新闻资讯";
            }
            
            YXWeakSelf
            [header setClickMoreBtnBlock:^(NSIndexPath * _Nonnull indexPath) {
                if (indexPath.section == 2) {
                    DDPartyListViewController *vc = [DDPartyListViewController new];
                    vc.type = PartyListStateHome;
                    vc.navigationItem.leftBarButtonItem = [weakSelf customBackItemWithTitle:@"党务公开" Image:[UIImage imageNamed:@"navi_back_black"]];
                    vc.sign = @"1";
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else if (indexPath.section == 3) {
                    DDPartyViewController *vc = [DDPartyViewController new];
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
    
    if (indexPath.section == 1) { // 点击分类菜单
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *url= @"";
        if (indexPath.row == 0) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Party_Wish];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }else if (indexPath.row == 1) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Party_TwoReport];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }else if (indexPath.row == 2) {
            [self queryIsParty];
        }else if (indexPath.row == 3) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Party_ThreeLessons];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }
        if (url.length > 0) {
            DDWebViewController *webVC = [[DDWebViewController alloc] init];
            webVC.url = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }
 
    }else if (indexPath.section > 1) { // 点击列表
        NSArray *tem = self.dataArr[indexPath.section-2];
        DDPartyModel *partyModel = tem[indexPath.row];
        if (partyModel.entityModel.relType1 == 1) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSString *url= @"";
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Party_Graphic];
            [dic setValue:partyModel.entityModel.ID forKey:@"id"];
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
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        DDWeakSelf
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
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
        [_collectionView registerClass:[DDPartyMenuCollectionViewCell class] forCellWithReuseIdentifier:@"DDPartyMenuCollectionViewCell"];
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
