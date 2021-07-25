//
//  DDScanViewController.m
//  DDLife
//
//  Created by wanggang on 2019/7/24.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "DDScanViewController.h"
#import <LBXScanViewStyle.h>
#import <LBXScanViewController.h>
#import <TZImagePickerController.h>
#import "NSString+Addition.h"
#import "LBXScanViewStyle.h"
#import "DDWebManager.h"
@interface DDScanViewController ()

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;

@end

@implementation DDScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"扫描二维码";
    self.libraryType = SLT_Native;
//    self.scanCodeType = SCT_QRCode;
    self.isOpenInterestRect = YES;
    self.style = [self qqStyle];
    
    UIButton *btnPhoto = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [btnPhoto setTitle:@"相册" forState:UIControlStateNormal];
    [btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [btnPhoto setTitleColor:color_TextOne forState:UIControlStateNormal];
    btnPhoto.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    UIBarButtonItem *phonto = [[UIBarButtonItem alloc] initWithCustomView:btnPhoto];
    self.navigationItem.rightBarButtonItem = phonto;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [button setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(back)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBtn;
    [self configurateNavigationBarSetting];
    
}
- (void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configurateNavigationBarSetting {
    // 可滑动返回
    self.rt_disableInteractivePop = NO;
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FONT_NORMAL_PINGFANG(18), NSForegroundColorAttributeName:[UIColor blackColor]}];
//    self.navigationController.navigationBar.barTintColor = NAVI_BG_COLOR;
    self.navigationController.navigationBar.translucent = NO;
    
    if (self.navigationController.viewControllers.count>1) {
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
//     [LBXScanWrapper systemVibrate];
    //声音提醒
    //[LBXScanWrapper systemSound];
    
    [self showNextVCWithScanResult:scanResult.strScanned];
    
}
- (void)showNextVCWithScanResult:(NSString *)reslut{
    DDWeakSelf;
    [self stopScan];
    
    NSString *url;
    NSError * error;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([reslut hasPrefix:@"http"]) {
        NSString *link = [NSString stringWithFormat:@"%@&",reslut];
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        if (self.scanSuccessReslut) {
            [self stopScan];
            self.scanSuccessReslut(url);
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }
    }else if ([reslut containsString:@"propertyId"]||[reslut containsString:@"merchantId"]) {
        
        NSData * m_data = [reslut  dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization  JSONObjectWithData:m_data options:NSJSONReadingMutableContainers error:&error];
        NSString *link;
        if ([reslut containsString:@"propertyId"]) {
            [dic setValue:dataDic[@"propertyId"] forKey:@"propertyId"];
            link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_PropertyManage];
        }
        if ([reslut containsString:@"merchantId"]) {
            [dic setValue:dataDic[@"merchantId"] forKey:@"merchantId"];
            link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Merchant];
        }
        url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        if (self.scanSuccessReslut) {
            [self stopScan];
            if (self.type == 0) {
                self.scanSuccessReslut(url);
            }else {
                self.scanSuccessReslut(reslut);
            }
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }
     
    }else {
        KPOP(@"二维码不识别");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf stopScan];
            [weakSelf reStartDevice];
        });
        
    }
    
    
    
//    if (_type == DDSCANTYPEALL) {
//        NSError * error;
//        NSData * m_data = [reslut  dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization  JSONObjectWithData:m_data options:NSJSONReadingMutableContainers error:&error];
//        if (dic[@"dshPayNo"]) {
//            NSDictionary *value = dic[@"dshPayNo"];
//            NSString *orderNO = value[@"dshorderNo"];
//            NSString *dconsumerCode = value[@"dsdconsumerCode"];
//            if (self.scanSuccessReslut) {
//                self.scanSuccessReslut(dconsumerCode);
//                [self dismissViewControllerAnimated:NO completion:nil];
//                
//            }else{
//                [self verOrderNO:orderNO payNo:dconsumerCode];
//            }
//        }else{
//            KPOP(@"未扫描到消费码");
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf stopScan];
//                [weakSelf reStartDevice];
//            });
//        }
//    }else if (_type == DDSCANTYPECoustomNo){
//        NSError * error;
//        NSData * m_data = [reslut  dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization  JSONObjectWithData:m_data options:NSJSONReadingMutableContainers error:&error];
//        if (dic[@"dshPayNo"]) {
//            NSDictionary *value = dic[@"dshPayNo"];
//            NSString *orderNO = value[@"dshorderNo"];
//            NSString *dconsumerCode = value[@"dsdconsumerCode"];
////            if (self.scanSuccessReslut) {
////                self.scanSuccessReslut(dconsumerCode);
////                [self dismissViewControllerAnimated:NO completion:nil];
////
////            }
//            if (self.scanCoustomSuccessReslut) {
//                self.scanCoustomSuccessReslut(dconsumerCode, orderNO);
//                [self dismissViewControllerAnimated:NO completion:nil];
//            }
//        }else{
//            KPOP(@"未扫描到消费码");
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf stopScan];
//                [weakSelf reStartDevice];
//            });
//        }
//    }else if (_type == DDSCANTYPEExpressNO){
//        if ([reslut isNumberOrEnglishCharacter]) {
//            if (self.scanSuccessReslut) {
//                self.scanSuccessReslut(reslut);
//                [self dismissViewControllerAnimated:NO completion:nil];
//
//            }
//        }else{
//            KPOP(@"未扫描到快递单号");
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf stopScan];
//                [weakSelf reStartDevice];
//            });
//        }

//    }


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_topTitle) {
        [self setUI];
    }
}
- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    UIAlertView   * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:@"该图片没有包含一个二维码！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
    [alertView show];
    
}
- (void)setUI{
    [self.view addSubview:self.topTitle];
    [self.view addSubview:self.btnFlash];
    [self.topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(44);
        make.width.equalTo(@200);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.btnFlash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
        make.size.mas_equalTo(CGSizeMake(65, 87));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.view bringSubviewToFront:_topTitle];
    //    [self.view bringSubviewToFront:_btnFlash];
    
}
- (UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle = [UILabel new];
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        _topTitle.font = [UIFont systemFontOfSize:14];
    }
    return _topTitle;
}
- (UIButton *)btnFlash{
    if (!_btnFlash) {
        _btnFlash = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
        [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnFlash;
}

- (LBXScanViewStyle*)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}
//打开相册
- (void)openPhoto
{
     [self openLocalPhoto:NO];
}


//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}
- (NSDictionary *)parmDic:(NSString *)url{
    NSArray *keyValues = [url componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    for (NSString *keyValue in keyValues) {
        NSArray *arr = [keyValue componentsSeparatedByString:@"="];
        if (arr.count > 1) {
            [dic setValue:arr[1] forKey:arr[0]];
        }
        
    }
    return dic;
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
