//
//  Config.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#ifndef Config_h
#define Config_h


// 弱引用
#define DDWeakSelf  __weak typeof(self) weakSelf = self;
#define YXWeakSelf  DDWeakSelf;
#define YXWeakCell  __weak typeof(cell) weakCell = cell;
// 强引用
#define YXStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

//获取项目版本号
#define BunldVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

#pragma mark - 时间相关
// 定义网络请求超时时间
#define NETWORKING_TIMEOUT_SECONDS  20.0f
// 气泡提示时间
#define PROMPT_TIME                 2.0f
// 轮播图时间
#define CAROUSEL_TIME               5.0f
// 短信倒计时时间为 60s
#define SEND_SMS_CODE_COUNTDOWN     60.0f



#pragma mark - 手机系统相关
//手机系统版本
#define CurrentIOSVersion  ([[[UIDevice currentDevice] systemVersion] floatValue])

// 用户机型判断宏
#define CurrentModeSize [[UIScreen mainScreen] currentMode].size

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 判断iPhone5系列
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), CurrentModeSize) && !isPad : NO)
// 判断iPhone6系列(包含iPhone6/iPhone7/iPhone8)
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), CurrentModeSize) && !isPad : NO)
// 判断iphone6P系列(包含iPhone6P/iPhone7P/iPhone8P)
#define KIS_IPHONE_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), CurrentModeSize) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), CurrentModeSize) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), CurrentModeSize)&& !isPad : NO)
//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)
//导航栏高度
#define NAV_BAR_HEIGHT              (IS_PhoneXAll ? 88.0 : 64.0)
#define SafeAreaTopHeight           NAV_BAR_HEIGHT
//底部操作栏高度
#define Home_Indicator_HEIGHT       (IS_PhoneXAll ? 34.0 : 0.0)
#define BOTTOM_SAFE_HEIGHT          Home_Indicator_HEIGHT
//tabbar高度
#define TABBAR_HEIGHT (IS_PhoneXAll ? 83.0 : 49.0)
//状态栏高度
#define STATUS_HEIGHT (IS_PhoneXAll ? 44 : 20)

#pragma mark - 网络请求方式
//GET
#define NETWORK_TYPE_GET    @"GET"
//POST
#define NETWORK_TYPE_POST   @"POST"
//PUT
#define NETWORK_TYPE_PUT    @"PUT"


#pragma mark - 常用
//语言转换
#define Language_Exchang(string)  NSLocalizedString(string, nil)

// 获取屏幕的宽度及高度
#define SCREEN_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define KWIDTH          SCREEN_WIDTH
#define SCREEN_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define kHEIGHT         SCREEN_HEIGHT

//把nil、null(简称NN)替换为空字符串 @""
#define DD_STRING_NN(x) if(x == nil || [x isKindOfClass:[NSNull class]]){x = @"";}


//打印Log
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
//#define NSLog(FORMAT, ...) nil
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#endif


#endif /* Config_h */
