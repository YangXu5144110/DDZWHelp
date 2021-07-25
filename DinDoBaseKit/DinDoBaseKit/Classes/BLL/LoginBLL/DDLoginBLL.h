//
//  DDLoginBLL.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "BaseBLL.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDLoginBLL : BaseBLL

+ (DDLoginBLL *)sharedLoginBLL;

// 查询CRM成功
typedef void (^onCRMSuccess)(NSArray *listArr);

// 登录成功
typedef void (^onLoginSuccess)(NSDictionary *dataDic);

// 登出成功
typedef void (^onLogoutSuccess)(void);


/**
查询CRM

@param mobile 手机号码
@param onCRMSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryEgsCRMUserWithMobile:(NSString *)mobile
                    onCRMSuccess:(onCRMSuccess)onCRMSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

/**
登录

@param mobile 物业的url
@param account 手机号码
@param password 密码
@param onLoginSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)requestLoginWithUrl:(NSString *)url
                    Account:(NSString *)account
                   Password:(NSString *)password
             onLoginSuccess:(onLoginSuccess)onLoginSuccess
                  bllFailed:(bllFailed)bllFailed
              onNetWorkFail:(onNetWorkFail)onNetWorkFail
           onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;







/**
登出

@param onLogoutSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
-(void)requestLogoutOnLogoutSuccess:(onLogoutSuccess)onLogoutSuccess
                          bllFailed:(bllFailed)bllFailed
                      onNetWorkFail:(onNetWorkFail)onNetWorkFail
                   onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;



@end

NS_ASSUME_NONNULL_END
