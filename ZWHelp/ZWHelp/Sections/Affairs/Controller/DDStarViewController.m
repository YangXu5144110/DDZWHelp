//
//  DDStarViewController.m
//  ZWHelp
//
//  Created by 杨旭 on 2021/1/30.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDStarViewController.h"
#import "DDPublicPopupViewController.h"
#import "DDPopNavViewController.h"

#import "DDStarLevelCollectionViewCell.h"
#import "DDStarReportCollectionViewCell.h"
#import "DDStarGoodsCollectionViewCell.h"
#import "DDAffairsBLL.h"
#import "DDStarModel.h"
@interface DDStarViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *periodArr;
@property (nonatomic ,strong) NSMutableArray *starArr;
@property (nonatomic ,strong) NSMutableArray *extendArr;
@property (nonatomic ,strong) NSMutableArray *goodsArr;

@property (nonatomic ,strong) DDPeriodModel *periodModel;
@property (nonatomic ,strong) DDStarModel *starModel;

@end

@implementation DDStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"星级评定";

    self.periodArr = [NSMutableArray array];
    self.extendArr = [NSMutableArray array];
    self.goodsArr = [NSMutableArray array];
    self.starArr = [NSMutableArray array];
    NSArray *gradeArr = @[@"五星",@"四星",@"三星",@"二星",@"一星",@"零星"];
    NSArray *gradeIdArr = @[@"5",@"4",@"3",@"2",@"1",@"0"];
    for (int i = 0; i < gradeArr.count; i ++) {
        NSString *grade = [gradeArr objectAtIndex:i];
        NSString *gradeId = [gradeIdArr objectAtIndex:i];
        DDStarModel *starModel = [[DDStarModel alloc] init];
        starModel.Id = gradeId;
        starModel.grade = grade;
        [self.starArr addObject:starModel];
    }

    [self loadData];
    
    [self loadSubViews];
}

- (void)loadData {
 
    DDWeakSelf
    [YJProgressHUD showLoading:@""];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[DDAffairsBLL sharedAffairsBLL] queryGetSelectDatSuccess:^(NSDictionary * _Nonnull dic) {
        weakSelf.periodArr = [DDPeriodModel mj_objectArrayWithKeyValuesArray:dic[@"allPeriod"]];
        if (weakSelf.periodArr.count) {
            if (weakSelf.periodModel) {
                for (DDPeriodModel *periodModel in weakSelf.periodArr) {
                    if ([periodModel.period isEqualToString:weakSelf.periodModel.period]) {
                        periodModel.selected = YES;
                    }else {
                        periodModel.selected = NO;
                    }
                }
            }else {
                weakSelf.periodModel = [weakSelf.periodArr firstObject];
                weakSelf.periodModel.selected = YES;
            }
        }
        dispatch_group_leave(group);
    } bllFailed:^(NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } onRequestTimeOut:^{
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [[DDAffairsBLL sharedAffairsBLL] queryStarListDataWithPeriod:self.periodModel.period gradeId:self.starModel.Id onStarListSuccess:^(NSDictionary * _Nonnull dic) {
        weakSelf.goodsArr = [DDStarGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        weakSelf.extendArr = [DDExtendModel mj_objectArrayWithKeyValuesArray:dic[@"extend"]];
        dispatch_group_leave(group);
    } bllFailed:^(NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } onRequestTimeOut:^{
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        [weakSelf.collectionView reloadData];
        [YJProgressHUD hideHUD];
    });
    
}

#pragma mark - SubViews
- (void)loadSubViews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3 + self.goodsArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 2){
        return CGSizeMake(KWIDTH -30, 78);
    }else if (indexPath.section == 1){
        return CGSizeMake(KWIDTH -30, 274);
    }else {
        return CGSizeMake(KWIDTH -30, 130);
    }
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
    return UIEdgeInsetsMake(0, 15, 15, 15);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 2){
        DDStarLevelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDStarLevelCollectionViewCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        if (indexPath.section == 0) {
            cell.content = self.periodModel.period;
        }else {
            cell.content = self.starModel.grade;
        }
        return cell;
    }else if (indexPath.section == 1){
        DDStarReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDStarReportCollectionViewCell" forIndexPath:indexPath];
        cell.extendArr = self.extendArr;
        return cell;
    }else {
        DDStarGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDStarGoodsCollectionViewCell" forIndexPath:indexPath];
        cell.goodsModel = self.goodsArr[indexPath.section - 3];
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 2) {
        DDPublicPopupViewController *popVC = [DDPublicPopupViewController new];
        if (indexPath.section == 0) {
            popVC.type = 0;
            popVC.listArr = self.periodArr;
        }else {
            popVC.type = 1;
            popVC.listArr = self.starArr;
        }
        DDWeakSelf
         DDPopNavViewController *nav = [[DDPopNavViewController alloc] initWithRootViewController:popVC];
         [nav popupWithPopType:HWPopTypeSlideInFromBottom dismissType:HWDismissTypeSlideOutToBottom position:HWPopPositionBottom];
        [popVC setClickSelectIndex:^(NSIndexPath * _Nonnull index) {
            if (indexPath.section == 0) {
                weakSelf.periodModel = self.periodArr[index.row];
            }else {
                weakSelf.starModel = self.starArr[index.row];
            }
            [weakSelf loadData];
        }];
    }
}

#pragma mark - Lazy Loading
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = color_BackColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_collectionView registerClass:[DDStarLevelCollectionViewCell class] forCellWithReuseIdentifier:@"DDStarLevelCollectionViewCell"];
        [_collectionView registerClass:[DDStarReportCollectionViewCell class] forCellWithReuseIdentifier:@"DDStarReportCollectionViewCell"];
        [_collectionView registerClass:[DDStarGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"DDStarGoodsCollectionViewCell"];
        
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
