//
//  DDMineViewController.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/13.
//

#import "DDMineViewController.h"
#import "DDSettingViewController.h"
#import "DDUserInfoViewController.h"
#import "DDWebViewController.h"

#import "DDMineHeaderView.h"
#import "DDMineTableView.h"

#import "DDWebManager.h"
@interface DDMineViewController ()

@property (nonatomic ,strong) DDMineHeaderView *headerView;

@property (nonatomic ,strong) DDMineTableView *tableView;

@end

@implementation DDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"我的" Image:[UIImage new]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_setting"] style:(UIBarButtonItemStyleDone) target:self action:@selector(settingAction)];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self loadSubViews];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryUserInfo) name:kNotificationImageUrl object:nil];
    
}

// 添加子视图
- (void)loadSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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

// 查询用户信息
- (void)queryUserInfo {
    [_headerView setInfoModel:[DDUserInfoManager getUserInfo]];
}


- (void)settingAction {
    DDSettingViewController *vc = [[DDSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushVCWithIndex:(NSInteger)index {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url= @"";
    if (index == 0) {
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Messege_All];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
    }else if (index == 1) {
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_PartyRZ];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
    }
    if (url.length > 0) {
        DDWebViewController *webVC = [[DDWebViewController alloc] init];
        webVC.url = url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark - Lazy Loading
- (DDMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DDMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 120)];
        [_headerView setInfoModel:[DDUserInfoManager getUserInfo]];
        YXWeakSelf
        [_headerView setPushUserInfoVC:^{
            DDUserInfoViewController *vc = [[DDUserInfoViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}

- (DDMineTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DDMineTableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.tableHeaderView = [self headerView];
        YXWeakSelf
        [_tableView setClickSelectRowAtIndexPath:^(NSIndexPath * _Nonnull indexPath) {
            if (indexPath.row == 0 || indexPath.row == 1) {
                [weakSelf pushVCWithIndex:indexPath.row];
            }
        }];
    }
    return _tableView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
