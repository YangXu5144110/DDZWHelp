//
//  DDForgetViewController.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/14.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDForgetViewController.h"
#import "LTLimitTextField.h"

@interface DDForgetViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIBarButtonItem *leftItme;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *phoneLab;
@property (nonatomic, strong) LTLimitTextField *phoneTF;
@property (nonatomic, strong) UILabel *codeLab;
@property (nonatomic, strong) LTLimitTextField *codeTF;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation DDForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
    
    
    if (self.registType == RegistShowType_Forget) {
        self.leftItme = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(click)];
        self.phoneLab.text = @"手机号码";
        self.codeLab.text = @"验证码";
        self.phoneTF.placeholder = @"请输入手机号";
        self.codeTF.placeholder = @"请输入验证码";
        self.codeBtn.hidden = NO;
        [self.doneBtn setTitle:@"下一步" forState:UIControlStateNormal];
        
        self.phoneTF.textLimitType = LTTextLimitTypeLength;
        self.phoneTF.textLimitSize = 11;
        self.codeTF.textLimitType = LTTextLimitTypeLength;
        self.codeTF.textLimitSize = 4;
        
    } else if (self.registType == RegistShowType_LoginPsd) {
        self.leftItme = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:(UIBarButtonItemStyleDone) target:self action:@selector(click)];
        self.phoneLab.text = @"新密码";
        self.codeLab.text = @"确认密码";
        self.phoneTF.placeholder = @"请输入新密码";
        self.codeTF.placeholder = @"请再次输入新密码";
        self.codeBtn.hidden = YES;
        [self.doneBtn setTitle:@"确定" forState:UIControlStateNormal];

        self.phoneTF.textLimitType = LTTextLimitTypeLength;
        self.phoneTF.textLimitSize = 16;
        self.codeTF.textLimitType = LTTextLimitTypeLength;
        self.codeTF.textLimitSize = 16;
        
    }
    self.leftItme.tintColor = color_TextOne;
    self.navigationItem.leftBarButtonItem = self.leftItme;
    
}
- (void)initSubviews {
    
    self.view.backgroundColor = [UIColor whiteColor];
       
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = color_TextOne;
    self.titleLab.text = @"重置密码";
    self.titleLab.font = [UIFont boldSystemFontOfSize:25.0];
    [self.view addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(29);
        make.top.equalTo(self.view.mas_top).offset(50);
        make.height.mas_equalTo(23);
    }];
    
    //PhoneTF
    self.phoneLab = [[UILabel alloc] init];
    self.phoneLab.textColor = color_TextOne;
    self.phoneLab.text = @"手机号码";
    self.phoneLab.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(29);
        make.top.equalTo(self.titleLab.mas_bottom).offset(50);
        make.height.mas_equalTo(13);
    }];
    
    
    self.phoneTF = [[LTLimitTextField alloc] init];
    self.phoneTF.placeholder = @"请输入手机号码";
    self.phoneTF.font = [UIFont systemFontOfSize:14];
    self.phoneTF.delegate = self;
    self.phoneTF.borderStyle = UITextBorderStyleNone;
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneTF addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(29);
        make.top.equalTo(self.phoneLab.mas_bottom).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-29);
        make.height.mas_equalTo(30);
    }];
    
    UIView *phoneLine = [UIView new];
    phoneLine.backgroundColor = color_LineColor;
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(self.phoneTF.mas_bottom).offset(5);
        make.left.equalTo(self.phoneTF.mas_left);
        make.right.equalTo(self.phoneTF.mas_right);
    }];
    
    
    //CodeTF
    self.codeLab = [[UILabel alloc] init];
    self.codeLab.textColor = color_TextOne;
    self.codeLab.text = @"验证码";
    self.codeLab.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:self.codeLab];
    [self.codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(29);
        make.top.equalTo(phoneLine.mas_bottom).offset(33);
        make.height.mas_equalTo(13);
    }];
    
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeBtn setBackgroundColor:MAIN_THEME_COLOR];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLab.mas_bottom).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-29);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
    }];
    
    self.codeTF = [[LTLimitTextField alloc] init];
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.font = [UIFont systemFontOfSize:14];
    self.codeTF.delegate = self;
    self.codeTF.borderStyle = UITextBorderStyleNone;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.codeTF addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLab.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(29);
        make.right.equalTo(self.codeBtn.mas_left).offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    UIView *codeLine = [UIView new];
    codeLine.backgroundColor = color_LineColor;
    [self.view addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(self.codeTF.mas_bottom).offset(5);
        make.left.equalTo(self.codeTF.mas_left);
        make.right.equalTo(self.codeBtn.mas_right);
    }];
    
    
    //DoneBtn
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneBtn.backgroundColor = MAIN_THEME_COLOR;
    self.doneBtn.layer.cornerRadius = 22.5f;
    self.doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.doneBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.top.equalTo(codeLine.mas_bottom).offset(160);
        make.left.equalTo(codeLine.mas_left);
        make.right.equalTo(codeLine.mas_right);
    }];
    
    
}

- (void)textFieldTextDidChanged:(LTLimitTextField *)sender {
    
    
}


#pragma mark - Touch Even
// 返回按钮
- (void)click {
    [self.navigationController popViewControllerAnimated:YES];
}
// 验证码
- (void)codeBtnClick:(UIButton *)sender {
    
    if (![self.phoneTF.text isValidateMobile]) {
        [self promptMsg:@"请输入正确的手机号"];
        return;
    }
    
    [self smsTimeCountDonw:sender];
}

// 确定
- (void)doneClick:(UIButton *)sender {
    
    if (self.registType == RegistShowType_Forget) {
        
        if (![self.phoneTF.text isValidateMobile]) {
            [self promptMsg:@"请输入正确的手机号"];
            return;
        }
        
        if ([NSString isBlankString:self.codeTF.text]) {
            [self promptMsg:@"请输入验证码"];
            return;
        }
        
        DDForgetViewController *vc = [[DDForgetViewController alloc] init];
        vc.registType = RegistShowType_LoginPsd;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (self.registType == RegistShowType_LoginPsd) {
        
        if ([NSString isBlankString:self.phoneTF.text]) {
            [self promptMsg:@"请输入新密码"];
            return;
        }
        
        if ([NSString isBlankString:self.codeTF.text]) {
            [self promptMsg:@"请再次输入新密码"];
            return;
        }
        
        if (![self.phoneTF.text isEqualToString:self.codeTF.text]) {
            [self promptMsg:@"两次密码不一致"];
            return;
        }
        
        
    }
    
    
    
}

- (void)smsTimeCountDonw:(UIButton *)sender {
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.1d)", seconds] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    
    dispatch_resume(_timer);
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
