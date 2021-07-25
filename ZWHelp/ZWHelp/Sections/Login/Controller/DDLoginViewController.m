//
//  DINDOLoginViewController.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/14.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDLoginViewController.h"
#import "DDForgetViewController.h"
#import "DDBaseTabBarController.h"


#import "DDPickerView.h"
#import "DDLoginBLL.h"
#import "DDCRMModel.h"

#define DDUSERPHONE @"DDUSERPHONE"
#define DDUSERPWD @"DDUSERPWD"
#define ISREMEMBER @"ISREMEMBER"

@interface DDLoginViewController ()<UITextFieldDelegate,PickerViewOneDelegate>

@property (nonatomic, strong) UIImageView *topLogoImgv;
@property (nonatomic, strong) LTLimitTextField *accountTF;
@property (nonatomic, strong) LTLimitTextField *psdTF;
@property (nonatomic, strong) UIButton *rememberBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) DDPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation DDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    [self loadSubViews];
    
    [self getUserDefault];

//    self.accountTF.text = @"18039686103";
//    self.psdTF.text = @"admin888";
}

- (void)loadSubViews {
    
    self.view.backgroundColor = [UIColor whiteColor];

    //TopImgv
    self.topLogoImgv = [[UIImageView alloc] init];
    self.topLogoImgv.image = [UIImage imageNamed:@"login_bg"];
    [self.view addSubview:self.topLogoImgv];
    [self.topLogoImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@263);
    }];
    
    //AccounrTF
    UIImageView *accountImgv = [[UIImageView alloc] init];
    accountImgv.image = [UIImage imageNamed:@"login_account"];
    [self.view addSubview:accountImgv];
    [accountImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.top.equalTo(self.topLogoImgv.mas_bottom).offset(30);
        make.width.height.mas_equalTo(20);
    }];
    
    self.accountTF = [[LTLimitTextField alloc] init];
    self.accountTF.placeholder = @"请输入手机号";
    self.accountTF.font = [UIFont systemFontOfSize:14];
    self.accountTF.delegate = self;
    self.accountTF.borderStyle = UITextBorderStyleNone;
    self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTF.tintColor = APPTintColor;
    self.accountTF.textLimitType = LTTextLimitTypeLength;
    self.accountTF.textLimitSize = 11;
    [self.view addSubview:self.accountTF];
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountImgv.mas_right).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(accountImgv.mas_centerY);
    }];
    
    UIView *accountLine = [UIView new];
    accountLine.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    [self.view addSubview:accountLine];
    [accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(self.accountTF.mas_bottom).offset(5);
        make.left.equalTo(accountImgv.mas_left);
        make.right.equalTo(self.accountTF.mas_right);
    }];
    
    
    //PsdTF
    UIImageView *psdImgv = [[UIImageView alloc] init];
    psdImgv.image = [UIImage imageNamed:@"login_psd"];
    [self.view addSubview:psdImgv];
    [psdImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.top.equalTo(accountLine.mas_bottom).offset(30);
        make.width.height.mas_equalTo(20);
    }];
    
    
    self.psdTF = [[LTLimitTextField alloc] init];
    self.psdTF.placeholder = @"请输入密码";
    self.psdTF.font = [UIFont systemFontOfSize:14];
    self.psdTF.delegate = self;
    self.psdTF.borderStyle = UITextBorderStyleNone;
    self.psdTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.psdTF.secureTextEntry = YES;
    self.psdTF.tintColor = APPTintColor;
    self.psdTF.textLimitType = LTTextLimitTypeLength;
    self.psdTF.textLimitSize = 16;
    [self.view addSubview:self.psdTF];
    [self.psdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psdImgv.mas_right).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(psdImgv.mas_centerY);
    }];
    
    UIView *psdLine = [UIView new];
    psdLine.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    [self.view addSubview:psdLine];
    [psdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(self.psdTF.mas_bottom).offset(5);
        make.left.equalTo(psdImgv.mas_left);
        make.right.equalTo(self.psdTF.mas_right);
    }];
    
    self.rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rememberBtn setTitleColor:[UIColor colorWithHexString:@"#BBBBBB"] forState:(UIControlStateNormal)];
    [self.rememberBtn setTitle:@"记住密码" forState:(UIControlStateNormal)];
    [self.rememberBtn setImage:[UIImage imageNamed:@"login_unremember"] forState:UIControlStateNormal];
    [self.rememberBtn setImage:[UIImage imageNamed:@"login_remember"] forState:UIControlStateSelected];
    self.rememberBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.rememberBtn addTarget:self action:@selector(rememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rememberBtn.selected = YES;
    [self.view addSubview:self.rememberBtn];
    [self.rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(psdLine.mas_bottom).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-40);
        [self.rememberBtn sizeToFit];
    }];
    
    
    //LoginBtn
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = MAIN_THEME_COLOR;
    self.loginBtn.layer.cornerRadius = 22.5f;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.top.equalTo(psdLine.mas_bottom).offset(60);
        make.left.equalTo(psdLine.mas_left);
        make.right.equalTo(psdLine.mas_right);
    }];
    
    
    //ForgetBtn
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.forgetBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.forgetBtn.hidden = YES;
    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(15);
        make.centerX.equalTo(self.loginBtn.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    
}

#pragma mark - 获取登录信息默认值
- (void)getUserDefault {

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL isRemeber = [[userDefault objectForKey:ISREMEMBER] boolValue];
    NSString *mobie = [userDefault objectForKey:DDUSERPHONE];
    NSString *password = [userDefault objectForKey:DDUSERPWD];
    self.rememberBtn.selected = isRemeber;
    self.accountTF.text = mobie;
    if (isRemeber == YES) {
        self.psdTF.text = password;
    }else {
        self.psdTF.text = nil;
    }
    
}


- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (DDPickerView *)pickerView {
    if (!_pickerView) {
        CGRect    pickerFrem = CGRectMake(0, kHEIGHT - 150,KWIDTH, 150);
        _pickerView = [[DDPickerView alloc] initWithFrame:pickerFrem
                                                        midArry:_listArr];
        _pickerView.delegate = self;
        _pickerView.title = @"";
    }
    return _pickerView;
}

#pragma mark - 选择物业
- (void)PickerViewOneDelegateOncleck:(NSIndexPath*)indePath{
  
    if (_listArr.count > 0) {
        DDCRMModel*crmModel= _listArr[indePath.row];
        if (crmModel.url.length > 0) {
            // 保存物业的url
            [[NSUserDefaults standardUserDefaults] setObject:crmModel.url forKey:@"baseUrl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self requestLoginWithUrl:crmModel.url];
        }
    }

}

// 请求登录接口
- (void)requestLoginWithUrl:(NSString *)url {
    
    [YJProgressHUD showLoading:@"登录中"];
    [[DDLoginBLL sharedLoginBLL] requestLoginWithUrl:url Account:self.accountTF.text Password:self.psdTF.text onLoginSuccess:^(NSDictionary * _Nonnull dataDic) {
        [YJProgressHUD hideHUD];
        DDUserInfoModel *model = [DDUserInfoModel mj_objectWithKeyValues:dataDic];
        [DDUserInfoManager saveUserInfoWithModel:model];
        DDBaseTabBarController *tabBar = [[DDBaseTabBarController alloc] init];
        tabBar.selectedIndex = 2;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
        
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
    
}


#pragma mark - Touch Even
// 记住密码
- (void)rememberBtnClick:(UIButton *)sender {
    sender.selected = ! sender.selected;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:sender.selected forKey:ISREMEMBER];
    [userDefault synchronize];
}

//登录
- (void)loginClick:(UIButton *)sender {
    
    if ([NSString isBlankString:self.accountTF.text]) {
        return [YJProgressHUD showMessage:@"请输入手机号"];
    }
    
    if ([NSString isBlankString:self.psdTF.text]) {
        return [YJProgressHUD showMessage:@"请输入密码"];
    }
    
    // 保存账号密码
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.accountTF.text forKey:DDUSERPHONE];
    [userDefault setObject:self.psdTF.text forKey:DDUSERPWD];
    [userDefault synchronize];
    
    
#if DevepMent == 1   // 测试环境
    [self requestLoginWithUrl:kBaseUrl];
#elif DevepMent == 2 // 正式环境

    YXWeakSelf
     [YJProgressHUD showLoading:@""];
     [[DDLoginBLL sharedLoginBLL] queryEgsCRMUserWithMobile:self.accountTF.text onCRMSuccess:^(NSArray * _Nonnull listArr) {
         [YJProgressHUD hideHUD];
         [weakSelf.listArr removeAllObjects];
         weakSelf.listArr = [DDCRMModel mj_objectArrayWithKeyValuesArray:listArr];
         if (listArr.count > 1) {
             [weakSelf.view addSubview:weakSelf.pickerView];
             [weakSelf.pickerView show];
             [weakSelf.pickerView setDataArr:weakSelf.listArr];
         }else {
             if (listArr.count > 0) {
                 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                 [weakSelf PickerViewOneDelegateOncleck:indexPath];
             }else {
                 [YJProgressHUD showMessage:@"未查询到物业公司"];
             }
         }
         
     } bllFailed:^(NSString * _Nonnull msg) {
         [YJProgressHUD showMessage:msg];
     } onNetWorkFail:^(NSString * _Nonnull msg) {
         [YJProgressHUD hideHUD];
     } onRequestTimeOut:^{
         [YJProgressHUD hideHUD];
     }];
#endif
    
}
//忘记密码
- (void)registerClick:(UIButton *)sender {
    
    DDForgetViewController *vc = [[DDForgetViewController alloc] init];
    vc.registType = RegistShowType_Forget;
    [self.navigationController pushViewController:vc animated:YES];

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
