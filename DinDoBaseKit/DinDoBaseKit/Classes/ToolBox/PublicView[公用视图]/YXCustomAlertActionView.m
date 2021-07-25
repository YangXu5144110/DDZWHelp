//
//  YXCustomAlertActionView.m
//  DDBLifeShops
//
//  Created by 杨旭 on 2019/3/13.
//  Copyright © 2019年 杨旭. All rights reserved.
//

#import "YXCustomAlertActionView.h"
#import "IQTextView.h"
#import "UIView+frameAdjust.h"
#import "ZKTimerService.h"

// 定义alertView 宽
#define AlertW  280

// 定义各个栏目之间的距离
#define Spce 10.0
// 定义自动关闭时间
#define countDownTime 3


// 定义提示弹框的时间
#define k_AlertTypeNotButtonTime 1.8


#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]
@interface YXCustomAlertActionView ()<UITextFieldDelegate,ZKTimerListener,UITableViewDelegate,UITableViewDataSource>


/** 弹窗类型*/
@property (nonatomic ,assign) AlertViewType type;
/** 弹窗视图*/
@property (nonatomic ,strong) UIView *alertView;
/** 标题*/
@property (nonatomic ,strong) UILabel *titleLab;
/** 消息*/
@property (nonatomic ,strong) UILabel *msgLab;
/** 输入框*/
@property (nonatomic ,strong) UITextField *textField;
/** 输入文本*/
@property (nonatomic ,strong) IQTextView *textView;
/** 列表*/
@property (nonatomic ,strong) UITableView *tableView;
/** 横线*/
@property (nonatomic ,strong) UIView *lineView;
/** 竖线*/
@property (nonatomic ,strong) UIView *verLineView;
/** 取消按钮*/
@property (nonatomic ,strong) UIButton *cancleBtn;
/** 确认*/
@property (nonatomic ,strong) NSString *sureTitle;
/** 取消*/
@property (nonatomic ,strong) NSString *cancleTitle;
/** 关闭按钮*/
@property (nonatomic ,strong) UIButton *closeBtn;

/**
 自动关闭时间
 */
@property (nonatomic ,assign) NSInteger countDown;

@end

@implementation YXCustomAlertActionView


- (void)setSureStr:(NSString *)sureStr {
    _sureStr = sureStr;
    [self.sureBtn setTitle:_sureStr forState:(UIControlStateNormal)];
}

- (void)setListArr:(NSArray *)listArr {
    _listArr = listArr;
    [self.tableView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame ViewType:(AlertViewType)type Title:(NSString *)title Message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle ;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sureTitle = sureTitle;
        self.cancleTitle = cancleTitle;
        self.limitEnterCount = MAXFLOAT;
        switch (type) {
            case AlertText:
            {
                
                if (message.length > 12) {
                    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertW, 160)];
                    self.alertView.backgroundColor = [UIColor whiteColor];
                    self.alertView.layer.cornerRadius=10.0;
                    self.alertView.layer.masksToBounds=YES;
                    self.alertView.userInteractionEnabled=YES;
                    [self addSubview:self.alertView];
                    
                    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 40)];
                    titleLab.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                    titleLab.text = title;
                    titleLab.font = [UIFont systemFontOfSize:16];
                    titleLab.textAlignment = NSTextAlignmentCenter;
                    [self.alertView addSubview:titleLab];
                    self.titleLab = titleLab;
                    
                    UILabel *messageLab = [[UILabel alloc]  initWithFrame:(CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 20, self.alertView.frame.size.width - 30, 40))];
                    messageLab.text = message;
                    messageLab.textAlignment = NSTextAlignmentCenter;
                    messageLab.font = [UIFont systemFontOfSize:15.0];
                    messageLab.textColor = NAVI_TITLE_SUB;
                    messageLab.numberOfLines = 0;
                    [self.alertView addSubview:messageLab];
                    self.msgLab = messageLab;
                    
                    self.lineView = [[UIView alloc] init];
                    self.lineView.frame = self.msgLab?CGRectMake(0, CGRectGetMaxY(self.msgLab.frame)+2*Spce, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+2*Spce, AlertW, 1);
                    self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
                    [self.alertView addSubview:self.lineView];
                }else {
                    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertW, 140)];
                    self.alertView.backgroundColor = [UIColor whiteColor];
                    self.alertView.layer.cornerRadius=10.0;
                    self.alertView.layer.masksToBounds=YES;
                    self.alertView.userInteractionEnabled=YES;
                    [self addSubview:self.alertView];
                    
                    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 40)];
                    titleLab.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                    titleLab.text = title;
                    titleLab.font = [UIFont systemFontOfSize:16];
                    titleLab.textAlignment = NSTextAlignmentCenter;
                    [self.alertView addSubview:titleLab];
                    self.titleLab = titleLab;
                    
                    UILabel *messageLab = [[UILabel alloc]  initWithFrame:(CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 20, self.alertView.frame.size.width - 30, 20))];
                    messageLab.text = message;
                    messageLab.textAlignment = NSTextAlignmentCenter;
                    messageLab.font = [UIFont systemFontOfSize:15.0];
                    messageLab.textColor = NAVI_TITLE_SUB;
                    messageLab.numberOfLines = 0;
                    [self.alertView addSubview:messageLab];
                    self.msgLab = messageLab;
                    
                    self.lineView = [[UIView alloc] init];
                    self.lineView.frame = self.msgLab?CGRectMake(0, CGRectGetMaxY(self.msgLab.frame)+2*Spce, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+2*Spce, AlertW, 1);
                    self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
                    [self.alertView addSubview:self.lineView];
                }

                
                [self addBtnUI];
                
            }
                break;
            case AlertTextField:
            {
            
                self.alertView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -AlertW)/2, (self.frame.size.width-200)/2, AlertW, 150)];
                self.alertView.backgroundColor = [UIColor whiteColor];
                self.alertView.layer.cornerRadius=10.0;
                self.alertView.layer.masksToBounds=YES;
                self.alertView.userInteractionEnabled=YES;
                [self addSubview:self.alertView];
                
                [self addObservers];
                
                UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 40)];
                titleLab.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                titleLab.text = title;
                titleLab.font = [UIFont systemFontOfSize:16];
                titleLab.textAlignment = NSTextAlignmentCenter;
                [self.alertView addSubview:titleLab];
                self.titleLab = titleLab;
                
                UITextField *textField = [[UITextField alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(titleLab.frame) + 20, self.alertView.width - 40, 30))];
                textField.placeholder = @"请输入您的姓名";
                textField.text = message;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.font = [UIFont systemFontOfSize:15.0];
                textField.tintColor = APPTintColor;
//                textField.keyboardType = UIKeyboardTypeDecimalPad;
                [textField becomeFirstResponder];
                [self.alertView addSubview:textField];
                self.textField = textField;

                self.lineView = [[UIView alloc] init];
                self.lineView.frame = self.textField?CGRectMake(0, CGRectGetMaxY(self.textField.frame)+2*Spce, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+2*Spce, AlertW, 1);
                self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
                [self.alertView addSubview:self.lineView];
                
                [self addBtnUI];

            }
                break;
            case AlertTextView:
            {
                self.alertView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -AlertW)/2, (self.frame.size.width-200)/2, AlertW, 200)];
                //        self.alertView.mj_centerX = SCREEN_WIDTH/2. + 35*SCALE;
                self.alertView.backgroundColor = [UIColor whiteColor];
                self.alertView.layer.cornerRadius=4.0;
                self.alertView.layer.masksToBounds=YES;
                self.alertView.userInteractionEnabled=YES;
                [self addSubview:self.alertView];
                
                [self addObservers];

                UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 40)];
                titleLab.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                titleLab.text = @"备注";
                titleLab.font = [UIFont systemFontOfSize:16];
                titleLab.textAlignment = NSTextAlignmentCenter;
                [self.alertView addSubview:titleLab];
                
                
                self.textView = [[IQTextView alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(titleLab.frame) + 20, self.alertView.width - 40, 60))];
                self.textView.placeholder = @"请输入备注内容";
                self.textView.font = [UIFont systemFontOfSize:14.0f];
                self.textView.layer.borderColor = BorderColor.CGColor;
                self.textView.layer.cornerRadius=4.0;
                self.textView.layer.masksToBounds=YES;
                self.textView.layer.borderWidth=1.0f;
                [self.textView becomeFirstResponder];
                [self.alertView addSubview:self.textView];
                
                [self addBtnUI];

            }
                break;
                
            case AlertTwoTextField:
            {
                
                self.alertView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -AlertW)/2, (self.frame.size.width-220)/2, AlertW, 220)];
                self.alertView.backgroundColor = [UIColor whiteColor];
                self.alertView.layer.cornerRadius=10.0;
                self.alertView.layer.masksToBounds=YES;
                self.alertView.userInteractionEnabled=YES;
                [self addSubview:self.alertView];
                
                [self addObservers];
                
                UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 40)];
                titleLab.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                titleLab.text = title;
                titleLab.font = [UIFont systemFontOfSize:16];
                titleLab.textAlignment = NSTextAlignmentCenter;
                [self.alertView addSubview:titleLab];
                self.titleLab = titleLab;
                
                UILabel *oAddressLab = [[UILabel alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(titleLab.frame) + 10, self.alertView.width - 40, 20))];
                oAddressLab.text = @"原收货地址";
                oAddressLab.textColor = [UIColor blackColor];
                oAddressLab.font = [UIFont systemFontOfSize:14.0f];
                [self.alertView addSubview:oAddressLab];
                
                
                UITextField *textField = [[UITextField alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(oAddressLab.frame) , self.alertView.width - 40, 30))];
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.font = [UIFont systemFontOfSize:15.0];
                textField.tintColor = APPTintColor;
                textField.enabled = NO;
                textField.text = message;
                //                textField.keyboardType = UIKeyboardTypeDecimalPad;
                [self.alertView addSubview:textField];
                
                
                UILabel *newAddressLab = [[UILabel alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(textField.frame) + 10, self.alertView.width - 40, 20))];
                newAddressLab.text = @"新收货地址";
                newAddressLab.textColor = [UIColor blackColor];
                newAddressLab.font = [UIFont systemFontOfSize:14.0f];
                [self.alertView addSubview:newAddressLab];
                
                
                UITextField *textField2 = [[UITextField alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(newAddressLab.frame) , self.alertView.width - 40, 30))];
                textField2.placeholder = @"请输入新的收货地址";
                textField2.borderStyle = UITextBorderStyleRoundedRect;
                textField2.font = [UIFont systemFontOfSize:15.0];
                textField2.tintColor = APPTintColor;
                //                textField.keyboardType = UIKeyboardTypeDecimalPad;
                [textField2 becomeFirstResponder];
                [self.alertView addSubview:textField2];
                self.textField = textField2;

                
                self.lineView = [[UIView alloc] init];
                self.lineView.frame = textField2?CGRectMake(0, CGRectGetMaxY(textField2.frame)+2*Spce, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+2*Spce, AlertW, 1);
                self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
                [self.alertView addSubview:self.lineView];
                
                [self addBtnUI];
        
                
            }
                break;
                
                
            case AlertTextTable:
            {
                self.alertView = [[UIView alloc]initWithFrame:CGRectMake(50, (self.frame.size.width-2 * 44)/2, KWIDTH-100,40 +  2 * 44 )];
                //        self.alertView.mj_centerX = SCREEN_WIDTH/2. + 35*SCALE;
                self.alertView.backgroundColor = [UIColor whiteColor];
                self.alertView.layer.cornerRadius=4.0;
                self.alertView.layer.masksToBounds=YES;
                self.alertView.userInteractionEnabled=YES;
                [self addSubview:self.alertView];
                
                
                UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 40)];
                titleLab.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                titleLab.text = title;
                titleLab.font = [UIFont systemFontOfSize:16];
                titleLab.textAlignment = NSTextAlignmentCenter;
                [self.alertView addSubview:titleLab];
                
                self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 40,self.alertView.frame.size.width , 88)) style:(UITableViewStylePlain)];
                self.tableView.backgroundColor = [UIColor whiteColor];
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                [self.alertView addSubview:self.tableView];
                
                
            }
                break;
            default:
                break;
        }
    

        
        self.type = type;
        
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
}
- (void)setLimitEnterCount:(NSInteger)limitEnterCount{
    _limitEnterCount = limitEnterCount;
    [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldChanged:(UITextField*)textField{
    if (_textField.text.length > _limitEnterCount) {
        _textField.text = [_textField.text substringWithRange:NSMakeRange(0, _limitEnterCount)];
        
    }
    
}

- (void)addBtnUI {
    
    
    if(self.sureTitle && self.cancleTitle){
        
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
        [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
        [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
        [self.cancleBtn setTitle:self.cancleTitle forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.cancleBtn.tag = 2;
        [self.cancleBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.cancleBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.cancleBtn.layer.mask = maskLayer;
        
        [self.alertView addSubview:self.cancleBtn];
        
    }
    if (self.cancleTitle && self.sureTitle) {
        self.verLineView = [[UIView alloc] init];
        self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
        self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.verLineView];
    }
    //两个按钮
    if (self.cancleTitle && self.sureTitle) {
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
        [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
        [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
        [self.sureBtn setTitle:self.sureTitle forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:APPTintColor forState:UIControlStateNormal];
        self.sureBtn.tag = 1;
        [self.sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.sureBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.sureBtn.layer.mask = maskLayer;
        
        [self.alertView addSubview:self.sureBtn];
    }

    //只有确定按钮
    if(self.sureTitle && !self.cancleTitle){
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
        [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
        [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
        [self.sureBtn setTitle:self.sureTitle forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:APPTintColor forState:UIControlStateNormal];
        self.sureBtn.tag = 2;
        [self.sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.sureBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.sureBtn.layer.mask = maskLayer;
        
        [self.alertView addSubview:self.sureBtn];
        
    }
    
    
}




#pragma mark - Pravite Method
- (void)addObservers{
    
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - Event response
- (void)keyboardWillShow:(NSNotification *)notif{
    
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat bgMaxY = CGRectGetMaxY(self.alertView.frame);
    CGFloat allH = height + bgMaxY;
    
    CGFloat subHeight = allH - (self.mj_h)+10;//10为缓冲距离
    
    //获取键盘动画时长
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //键盘遮挡才需上移
    if(subHeight>0){
        [UIView animateWithDuration:dutation animations:^{
            self.alertView.transform = CGAffineTransformMakeTranslation(0, - subHeight);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif{
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:dutation animations:^{
        self.alertView.transform = CGAffineTransformIdentity;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.listArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (self.sureClick) {
        self.sureClick(self.listArr[indexPath.row]);
    }
    [UIView animateWithDuration:0.3 animations:^{
         [self removeFromSuperview];
     }];
}


-(void)sureClick:(UIButton *)sender{
    [TIMER_SERVICE_INSTANCE removeListener:self];
    if (self.type == AlertText) {
        if (self.sureClick) {
            self.sureClick(self.textField.text);
        }
    }else if (self.type == AlertTextField) {
        if ([self.titleLab.text isEqualToString:@"自定义标签"]) {
            if ([self.textField.text isEqualToString:@""]) {
               return [YJProgressHUD showMessage:@"输入标签不能为空"];
            }
        }
        if (self.sureClick) {
            self.sureClick(self.textField.text);
        }
    }else if (self.type == AlertTextView) {
        if (self.sureClick) {
            self.sureClick(self.textView.text);
        }
    }else if (self.type == AlertTwoTextField) {
        if (self.sureClick) {
            self.sureClick(self.textField.text);
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}
- (void)startCountDown{
    _countDown = countDownTime + TIMER_SERVICE_INSTANCE.timeInterval;
    [TIMER_SERVICE_INSTANCE addListener:self];
    [self didOnTimer:TIMER_SERVICE_INSTANCE];
}
- (void)didOnTimer:(ZKTimerService *)service
{
    DDWeakSelf
    NSInteger leftTime = _countDown - TIMER_SERVICE_INSTANCE.timeInterval;
    if (leftTime >= 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.cancleBtn setTitle:[NSString stringWithFormat:@"取消(%lds)",(long)leftTime] forState:UIControlStateNormal];
        });
    }else{
        [self cancelClick:nil];
    }
}

- (void)cancelClick:(UIButton *)sender{
    [TIMER_SERVICE_INSTANCE removeListener:self];
    if (self.cancelClick) {
        self.cancelClick();
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
    
}

-(void)showAnimation{
    
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    if (self.type == AlertText || self.type == AlertTextTable) {
        self.alertView.layer.position = self.center;
    }
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    DDWeakSelf;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        weakSelf.alertView.transform = transform;
        weakSelf.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [TIMER_SERVICE_INSTANCE removeListener:self];
    if (self.hideClick) {
        self.hideClick();
    }
    [self.textField becomeFirstResponder];
    
    for (NSSet *set in event.allTouches) {
        UITouch *touch = (UITouch *)set;
        if (touch.view != self.alertView) {
            [UIView animateWithDuration:0.3 animations:^{
                [self removeFromSuperview];
            }];
        }
    }
}


- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
