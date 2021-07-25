//
//  DDAffairsViewController.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/13.
//

#import "DDAffairsViewController.h"
#import "DDWebViewController.h"
#import "DDAffairsHeaderView.h"
#import "DDAffairsCollectionViewCell.h"
#import "DDStarViewController.h"

#import "DDAffairsBLL.h"
#import "DDAffairsGroupModel.h"
#import "DDWebManager.h"
#import "UIScrollView+DREmptyDataSet.h"
#import <DDCacheManager.h>
@interface DDAffairsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView *collectionView;

@property (nonatomic ,strong) NSMutableArray *dataArr;
@end

@implementation DDAffairsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    if (isEnableCache == YES) {
//        NSArray *dataArr = [[DDCacheManager shareManager] getDataWithType:(CacheDataTypeAffairs)];
//        if (dataArr.count > 0) {
//            self.dataArr = [DDAffairsGroupModel mj_objectArrayWithKeyValuesArray:dataArr];
//        }else {
//            [self loadData];
//        }
//    }else {
        [self loadData];
//    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"政务" Image:[UIImage new]];

    [self loadSubViews];
    
}

- (void)loadData {
    
    YXWeakSelf
    [[DDAffairsBLL sharedAffairsBLL] queryGetModuleOnModuleSuccess:^(NSArray * _Nonnull listArr) {
        weakSelf.dataArr = [DDAffairsGroupModel mj_objectArrayWithKeyValuesArray:listArr];
        [weakSelf setOffLineCacheWith:listArr];
        
        [weakSelf.collectionView reloadData];
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [weakSelf getData];
    } onRequestTimeOut:^{
        [weakSelf getData];
    }];
    
}

#pragma mark - 保存离线缓存数据
- (void)setOffLineCacheWith:(NSArray *)listArr {
    
    if (isEnableCache == YES) {
        // 判断是否有数据
        if (listArr.count == 0) {
            return;
        }
        NSString *jsonStr = [listArr mj_JSONString];
        [[DDCacheManager shareManager] database];
        [[DDCacheManager shareManager] createTableWithType:CacheDataTypeAffairs];
        NSArray *dataArr = [[DDCacheManager shareManager] getDataWithType:(CacheDataTypeAffairs)];
        if (dataArr.count > 0) {
            NSString *jsonStr1 = [dataArr mj_JSONString];
            if ([jsonStr isEqualToString:jsonStr1]) {
                [[DDCacheManager shareManager] saveWithType:(CacheDataTypeAffairs) dataStr:jsonStr1];
            }else {
                [[DDCacheManager shareManager] saveWithType:(CacheDataTypeAffairs) dataStr:jsonStr];
            }
        }else {
            [[DDCacheManager shareManager] saveWithType:(CacheDataTypeAffairs) dataStr:jsonStr];
        }
    }
}

- (void)getData {
    if (isEnableCache == YES) {
        [[DDCacheManager shareManager] database];
        [[DDCacheManager shareManager] createTableWithType:CacheDataTypeAffairs];
        NSArray *dataArr = [[DDCacheManager shareManager] getDataWithType:(CacheDataTypeAffairs)];
        if (dataArr.count > 0) {
            self.dataArr = [DDAffairsGroupModel mj_objectArrayWithKeyValuesArray:dataArr];
            [self.collectionView reloadData];
        }
    }
}

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
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    DDAffairsGroupModel *groupModel = self.dataArr[section];
    return groupModel.childModule.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KWIDTH/5, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDAffairsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDAffairsCollectionViewCell" forIndexPath:indexPath];
    DDAffairsGroupModel *groupModel = self.dataArr[indexPath.section];
    cell.model = groupModel.childModule[indexPath.row];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDAffairsGroupModel *groupModel = self.dataArr[indexPath.section];
    DDAffairsModel *model = groupModel.childModule[indexPath.row];
    
    if ([model.moduleName isEqualToString:@"星级评定"]&&[model.moduleUrl isEqualToString:@"nativeStarRating"]) {
        DDStarViewController *vc = [DDStarViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *url= @"";
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,model.moduleUrl];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        DDWebViewController *vc = [[DDWebViewController alloc] init];
        vc.url = url;
        vc.searchTitle = model.searchTitle;
        vc.searchUrl = model.searchUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
 
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KWIDTH, 50);
}
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(KWIDTH, 10);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        DDAffairsHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        DDAffairsGroupModel *groupModel = self.dataArr[indexPath.section];
        header.titleLab.text = groupModel.name;
        return header;
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
             footerView.backgroundColor = [UIColor whiteColor];
        return footerView;
    }
    return nil;
}


#pragma mark - Lazy Loading
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[DDAffairsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        [_collectionView registerClass:[DDAffairsCollectionViewCell class] forCellWithReuseIdentifier:@"DDAffairsCollectionViewCell"];
        [_collectionView setupEmptyDataText:@"暂无数据" tapBlock:^{
   
        }];
    }
    return _collectionView;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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
