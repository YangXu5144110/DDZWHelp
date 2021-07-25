//
//  DDChangePasswordViewController.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDChangePwdViewController.h"
#import "DDChangePwdTableViewCell.h"
#import "DDUserBLL.h"
@interface DDChangePwdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSString *oldPwd;
@property (nonatomic ,strong) NSString *pwdOne;
@property (nonatomic ,strong) NSString *pwdTwo;

@end

@implementation DDChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"更改密码" Image:[UIImage imageNamed:@"navi_back_black"]];
    
    
    [self loadSubViews];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 3 : 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 80 : 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        static NSString *cellID = @"YXExitCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.textColor = color_RedColor;
        cell.textLabel.text= @"确认更改";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        static NSString *cellID = @"DDChangePwdTableViewCell";
        DDChangePwdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell) {
            cell = [[DDChangePwdTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        cell.indexPath = indexPath;
        YXWeakSelf
        if (indexPath.row == 0) {
            [cell setEditTextBlock:^(NSString * _Nonnull text) {
                weakSelf.oldPwd = text;
            }];
        }else if (indexPath.row == 1) {
            [cell setEditTextBlock:^(NSString * _Nonnull text) {
                weakSelf.pwdOne = text;
            }];
        }else if (indexPath.row == 2) {
            [cell setEditTextBlock:^(NSString * _Nonnull text) {
                weakSelf.pwdTwo = text;
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
    
    if (indexPath.section == 1) {
        [self rqeuestUpdatePwd];
    }
    
}

#pragma mark - 更改密码
- (void)rqeuestUpdatePwd {
    
    if ([NSString isBlankString:self.oldPwd]) {
        return [YJProgressHUD showMessage:@"请填写原密码"];
    }
    if ([NSString isBlankString:self.pwdOne]) {
        return [YJProgressHUD showMessage:@"请填写新密码"];
    }
    if ([NSString isBlankString:self.pwdTwo]) {
        return [YJProgressHUD showMessage:@"请再次填写确认"];
    }
    
    if (![self.pwdOne isEqualToString:self.pwdTwo]) {
        return [YJProgressHUD showMessage:@"两次填写密码不一致！"];
    }
    
    YXWeakSelf
    [YJProgressHUD showLoading:@""];
    [[DDUserBLL sharedUserBLL] updatePwdWithOldPassword:self.oldPwd newPassword:self.pwdOne onUpdatePwdSuccess:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [YJProgressHUD showSuccess:@"修改成功"];
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
    
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
        
        [_tableView registerClass:[DDChangePwdTableViewCell class] forCellReuseIdentifier:@"DDChangePwdTableViewCell"];
    }
    return _tableView;
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
