//
//  DDSettingViewController.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/14.
//

#import "DDSettingViewController.h"
#import "DDChangePwdViewController.h"
#import "DDLoginViewController.h"
#import "DDWebViewController.h"

#import "DDSettingTableViewCell.h"
#import "DDLoginBLL.h"
#import "DDUserBLL.h"
#import "DDSettingModel.h"
#import "SDImageCache.h"
#import "DDWebManager.h"

@interface DDSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) YXCustomAlertActionView *alertView;

@property (nonatomic ,strong) DDSettingModel *setModel;

@end

@implementation DDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"设置" Image:[UIImage imageNamed:@"navi_back_black"]];
    
    [self queryShare];
    
    [self loadSubViews];
}

#pragma mark - 查询共享手机号设置
- (void)queryShare {
    
    YXWeakSelf
    [[DDUserBLL sharedUserBLL] queryShareWithUserId:[DDUserInfoManager getUserInfo].userId OnShareSuccess:^(id  _Nonnull model) {
        weakSelf.setModel = [DDSettingModel mj_objectWithKeyValues:model];
        [weakSelf.tableView reloadData];
    } bllFailed:^(NSString * _Nonnull msg) {
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        
    } onRequestTimeOut:^{
        
    }];
}

#pragma mark - 设置共享手机号
- (void)updateShareWithState:(BOOL)state {
        
    [YJProgressHUD showLoading:@""];
    [[DDUserBLL sharedUserBLL] updateShareWithUserId:[DDUserInfoManager getUserInfo].userId State:state == NO ? @"0" : @"1" onUpdateShareSuccess:^{
        if (state == YES) {
            [YJProgressHUD showMessage:@"开启成功"];
        }else {
            [YJProgressHUD showMessage:@"关闭成功"];
        }
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
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

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 2;
    }else if (section == 3) {
        return 1;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 1 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 1)) {
        return 56;
    }
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        static NSString *cellID = @"YXExitCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.textColor = color_RedColor;
        cell.textLabel.text= @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        YXWeakSelf
        static NSString *cellID = @"DDSettingTableViewCell";
        DDSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell) {
            cell = [[DDSettingTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        cell.indexPath = indexPath;
        cell.setModel = self.setModel;
        if (indexPath.section == 1 && indexPath.row == 0) {
            [cell setSwtichOnOrOff:^(BOOL status) {
//                if (status) { // 开启
//                    [[UIApplication sharedApplication] registerForRemoteNotifications];
//                }else { // 关闭
//                    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
//                }
//                [weakSelf.tableView reloadData];
            }];
        }
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            [cell setSwtichOnOrOff:^(BOOL status) {
                [weakSelf updateShareWithState:status];
            }];
        }
        return cell;
        
    }
    return [[UITableViewCell alloc] init];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0 && indexPath.row == 0) {
        DDChangePwdViewController *vc = [DDChangePwdViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self showPopView];
        }else {
            DDWebViewController *webVC = [[DDWebViewController alloc] init];
            webVC.url = @"http://www.dd2007.com/gydd";
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    
    if (indexPath.section == 3) {
        [self.alertView showAnimation];
    }
}

#pragma mark -  点击清除缓存
- (void)showPopView {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否要清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[DDWebManager sharedWebManager] clearCache];
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^
         {
            [YJProgressHUD showMessage:@"已清除缓存完成"];
             [self.tableView reloadData];
         }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - 退出登录
- (void)requestLogout {
    
    YXWeakSelf
    [YJProgressHUD showLoading:@"正在退出..."];
     [[DDLoginBLL sharedLoginBLL] requestLogoutOnLogoutSuccess:^{
         [YJProgressHUD hideHUD];
         [weakSelf cleanUserInfo];
     } bllFailed:^(NSString * _Nonnull msg) {
         [YJProgressHUD hideHUD];
         [weakSelf cleanUserInfo];
     } onNetWorkFail:^(NSString * _Nonnull msg) {
         [YJProgressHUD hideHUD];
         [weakSelf cleanUserInfo];
     } onRequestTimeOut:^{
         [YJProgressHUD hideHUD];
         [weakSelf cleanUserInfo];
     }];
     
    
}
#pragma mark - 清空用户信息返回登录页
- (void)cleanUserInfo {
    
    [DDUserInfoManager cleanUserInfo];
    [[DDWebManager sharedWebManager] clearCache];
    [[DDCacheManager shareManager] removeDataFile];

    // 返回登录页面
    DDLoginViewController *vc = [[DDLoginViewController alloc] init];
    DDBaseNavigationController *nav = [[DDBaseNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self cyl_tabBarController] presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - Lazy Loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = color_LineColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0 );
        _tableView.separatorColor = color_LineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [_tableView registerClass:[DDSettingTableViewCell class] forCellReuseIdentifier:@"DDSettingTableViewCell"];
    }
    return _tableView;
}
- (YXCustomAlertActionView *)alertView {
    if (!_alertView) {
        _alertView = [[YXCustomAlertActionView alloc] initWithFrame:[UIScreen mainScreen].bounds ViewType:(AlertText) Title:@"提示" Message:@"确认退出登录吗？" sureBtn:@"确定" cancleBtn:@"取消"];
        YXWeakSelf
        [_alertView setSureClick:^(NSString * _Nonnull string) {
            [weakSelf requestLogout];
        }];
    }
    return _alertView;
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
