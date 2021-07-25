//
//  DDPartyViewController.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/13.
//

#import "DDPartyViewController.h"
#import "DDPartyListViewController.h"
#import <JXCategoryView.h>
#import "DDPartyBLL.h"
#import "DDPartyModel.h"

@interface DDPartyViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSMutableArray *titles;//标题数组
@property (nonatomic, strong) NSArray *keys;//标题数组
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//类型选择器
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;//类型视图选择器
@property (nonatomic, strong) NSMutableArray *typeArr;
@end

@implementation DDPartyViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"新闻资讯" Image:[UIImage imageNamed:@"navi_back_black"]];
    
    // 初始化默认值
    _titles = [NSMutableArray arrayWithObjects:@"推荐", nil];
    _keys = @[@"0"];
    [self loadData];
    [self addSubviewsToVcView];
}

- (void)loadData {
    
    YXWeakSelf
    [[DDPartyBLL sharedPartyBLL] queryNewsTypeListOnSuccess:^(NSArray * _Nonnull listArr) {
        NSMutableArray *tempArr = [NSMutableArray array];
        weakSelf.typeArr = [DDPartyTypeModel mj_objectArrayWithKeyValuesArray:listArr];
//        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"code" ascending:YES];
//        weakSelf.typeArr = [NSMutableArray arrayWithArray:[dataArr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]];
        for (DDPartyTypeModel *typeModel in weakSelf.typeArr) {
            [tempArr addObject:typeModel.name];
        }
        [weakSelf.titles addObjectsFromArray:tempArr];
        weakSelf.categoryView.titles = weakSelf.titles;
        [weakSelf.categoryView reloadData];
        [weakSelf.categoryView reloadDataWithoutListContainer]; // 刷新数据
    } bllFailed:^(NSString * _Nonnull msg) {
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        
    } onRequestTimeOut:^{
        
    }];
    
}


#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {

    DDPartyListViewController *list = [[DDPartyListViewController alloc] init];
    list.type = PartyListStateHome;
    if (index == 0) {
        list.sign = @"2";
    }
    if (index > 0) {
        list.typeModel = self.typeArr[index-1];
    }
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


#pragma mark - Intial Methods
- (void)addSubviewsToVcView{//添加子视图
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(@44);
        if (@available(iOS 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }else{
            make.top.mas_equalTo(0);
        }
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.categoryView.mas_bottom);
        if (@available(iOS 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.bottom.mas_equalTo(0);
        }
    }];
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc]init];
        _categoryView.delegate = self;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.titleFont = [UIFont systemFontOfSize:16.0];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:18.0];
        _categoryView.titleColor = color_TextOne;
        _categoryView.titleSelectedColor = APPTintColor;
        _categoryView.defaultSelectedIndex = 0;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        //可以试试宽度补偿
        lineView.indicatorColor = APPTintColor;
        lineView.indicatorHeight = 2;
        lineView.indicatorWidthIncrement = 0;
        lineView.verticalMargin = 6;
        _categoryView.indicators = @[lineView];
        _categoryView.titles = _titles;
        _categoryView.listContainer = self.listContainerView;
        _listContainerView = self.listContainerView;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    }
    return _listContainerView;
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
