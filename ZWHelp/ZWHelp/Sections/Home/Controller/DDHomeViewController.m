//
//  DDHomeViewController.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/13.
//

#import "DDHomeViewController.h"
#import "DDWebViewController.h"
#import "DDScanViewController.h"

#import "DDHomeMenuCollectionViewCell.h"
#import "DDHomeMessageCollectionViewCell.h"
#import "DDHomeNumberCollectionViewCell.h"
#import "YCMenuView.h"

#import "DDHomeBLL.h"
#import "DDHomeNumModel.h"
#import "DDWebManager.h"
@interface DDHomeViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDataSource>

@property (nonatomic ,strong) UIBarButtonItem *ppxBtn;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) DDHomeNumModel *numModel;
@property (nonatomic ,strong) DDHomeGridsModel *selectGridsModel;

@property (nonatomic ,strong) NSMutableArray *grids;
@property (nonatomic ,strong) NSDictionary *messegeDic;

@end

@implementation DDHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    [self initDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDefault];
    
    [self configNaviBar];

    [self loadSubViews];
       
}

#pragma mark - Initialize
- (void)initDefault {
        
    if ([DDUserInfoManager getUserInfo].grids.count > 0) {
        DDHomeGridsModel *gridsModel = [DDUserInfoManager getUserInfo].grids[0];
        self.selectGridsModel = gridsModel;
        [self queryGridInfoWithId:gridsModel.ID];
    }
}


#pragma mark - Navigation
- (void)configNaviBar
{
    NSString    *homeName=self.selectGridsModel.name.length > 0 ?  self.selectGridsModel.name : @"请添加物业";
    UIBarButtonItem *fangWuItem = [[UIBarButtonItem alloc] initWithTitle:homeName style:(UIBarButtonItemStyleDone) target:self action:@selector(roomBtnClick:)];
    fangWuItem.tintColor = [UIColor blackColor];
    [fangWuItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.ppxBtn = fangWuItem;
    UIBarButtonItem *arrowItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_down"] style:(UIBarButtonItemStyleDone) target:self action:@selector(roomBtnClick:)];
    
    UIBarButtonItem *scan = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_scan"] style:(UIBarButtonItemStyleDone) target:self action:@selector(scanClick)];
    
    self.navigationItem.leftBarButtonItems = @[fangWuItem,arrowItem];
    self.navigationItem.rightBarButtonItem = scan;
    
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


- (void)queryGridInfoWithId:(NSString *)Id {
    
    YXWeakSelf
    dispatch_group_t group = dispatch_group_create();
    [YJProgressHUD showLoading:@""];

    dispatch_group_enter(group);
    [[DDHomeBLL sharedHomeBLL] queryGridInfoWithId:Id onGridInfoSuccess:^(NSDictionary * _Nonnull dic) {
        weakSelf.numModel = [DDHomeNumModel mj_objectWithKeyValues:dic];
        dispatch_group_leave(group);
    } bllFailed:^(NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } onRequestTimeOut:^{
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);

    [[DDHomeBLL sharedHomeBLL] queryUnreadCountnSuccess:^(NSDictionary * _Nonnull dic) {
        weakSelf.messegeDic = dic;
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


#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [DDUserInfoManager getUserInfo].listModule.count;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 8;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0){
        return CGSizeMake(KWIDTH/5, 80);
    }else if (indexPath.section == 1){
        return CGSizeMake(KWIDTH -30, 48);
    }else if (indexPath.section == 2){
        return CGSizeMake((KWIDTH - 45)/2, 72);
    }
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0){
        return UIEdgeInsetsMake(0, 0, 15, 0);
    }else if (section == 1){
           return UIEdgeInsetsMake(0, 15, 15, 15);
    }else if (section == 2){
       return UIEdgeInsetsMake(0, 15, 15, 15);
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return 15;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0){
        DDHomeMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeMenuCollectionViewCell" forIndexPath:indexPath];
        DDHomeMenuModel *menuModel = [DDUserInfoManager getUserInfo].listModule[indexPath.row];
        cell.menuModel = menuModel;
        return cell;
    }else if (indexPath.section == 1){
        DDHomeMessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeMessageCollectionViewCell" forIndexPath:indexPath];
        cell.messegeDic = _messegeDic;
        return cell;
    }else if (indexPath.section == 2){
        DDHomeNumberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeNumberCollectionViewCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.numModel = self.numModel;
        return cell;
    }
    return nil;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url= @"";
    if (indexPath.section == 0) {
        DDHomeMenuModel *model = [DDUserInfoManager getUserInfo].listModule[indexPath.row];
        if ([model.moduleName isEqualToString:@"全部"]) {
            self.tabBarController.selectedIndex = 1;
            return;
        }
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,model.moduleUrl];
        [dic setValue:model.moduleUrl forKey:@"meshingId"];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Home_Meshing];
            [dic setValue:self.selectGridsModel.ID forKey:@"meshingId"];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }else if (indexPath.row == 1) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Home_PublicBuilding];
            [dic setValue:self.selectGridsModel.ID forKey:@"meshingId"];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }else if (indexPath.row == 2) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Home_PublicBuilding];
            [dic setValue:self.selectGridsModel.ID forKey:@"meshingId"];
            [dic setValue:@"1" forKey:@"type"];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }else if (indexPath.row == 3) {
            NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Home_PublicBuilding];
            [dic setValue:self.selectGridsModel.ID forKey:@"meshingId"];
            [dic setValue:@"2" forKey:@"type"];
            url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        }
    }else if (indexPath.section == 1){
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Messege_All];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
    }
    if (url.length > 0) {
        DDWebViewController *webVC = [[DDWebViewController alloc] init];
        webVC.url = url;
        [self.navigationController pushViewController:webVC animated:YES];
    }


}


- (void)roomBtnClick:(UIBarButtonItem *)sender {
    
    [self.grids removeAllObjects];
    if ([DDUserInfoManager getUserInfo].grids.count > 0) {
        YXWeakSelf
        for (DDHomeGridsModel *gridsModel in [DDUserInfoManager getUserInfo].grids) {
            YCMenuAction *action = [YCMenuAction actionWithTitle:gridsModel.name image:nil handler:^(YCMenuAction *action) {
                weakSelf.ppxBtn.title = action.title;
                if ([gridsModel.name containsString:action.title]) {
                    NSLog(@"点击了%@",gridsModel.ID);
                    [weakSelf queryGridInfoWithId:gridsModel.ID];
                }
            }];
            [self.grids addObjectsFromArray:@[action]];
        }
        
        if (self.grids.count > 0) {
            YCMenuView *view = [YCMenuView menuWithActions:self.grids width:150 relyonView:self.ppxBtn];
            [view show];
        }
    }
   
}

- (void)scanClick {
    
    DDWeakSelf
    DDScanViewController *scanVC = [DDScanViewController new];
    scanVC.scanSuccessReslut = ^(NSString * _Nonnull reslut) {
        DDWebViewController *vc = [DDWebViewController new];
        vc.url = reslut;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    scanVC.modalPresentationStyle = UIModalPresentationFullScreen;
    DDBaseNavigationController *nav = [[DDBaseNavigationController alloc]initWithRootViewController:scanVC];
    [weakSelf presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Lazy Loading
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
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
        
        [_collectionView registerClass:[DDHomeMenuCollectionViewCell class] forCellWithReuseIdentifier:@"DDHomeMenuCollectionViewCell"];
        [_collectionView registerClass:[DDHomeMessageCollectionViewCell class] forCellWithReuseIdentifier:@"DDHomeMessageCollectionViewCell"];
        [_collectionView registerClass:[DDHomeNumberCollectionViewCell class] forCellWithReuseIdentifier:@"DDHomeNumberCollectionViewCell"];
        
    }
    return _collectionView;
}
- (NSMutableArray *)grids {
    if (!_grids) {
        _grids = [NSMutableArray array];
    }
    return _grids;
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
