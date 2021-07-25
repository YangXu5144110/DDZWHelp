//
//  DDLoginBLL.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDLoginBLL.h"

@implementation DDLoginBLL

+ (DDLoginBLL *)sharedLoginBLL
{
    
    static DDLoginBLL *loginBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        loginBLL = [[self alloc] init];
    });
    
    return loginBLL;
}


- (void)queryEgsCRMUserWithMobile:(NSString *)mobile
                    onCRMSuccess:(onCRMSuccess)onCRMSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kCRMUrl,@"auth/anon/egs/user/queryEgsUser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:mobile forKey:@"mobile"];
    [params setValue:@"cmg" forKey:@"appSign"];
    [params setValue:kAppType forKey:@"appType"];
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSArray *listArr = resultDic[@"data"];
            onCRMSuccess(listArr);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}

- (void)requestLoginWithUrl:(NSString *)url
                    Account:(NSString *)account
                   Password:(NSString *)password
             onLoginSuccess:(onLoginSuccess)onLoginSuccess
                  bllFailed:(bllFailed)bllFailed
              onNetWorkFail:(onNetWorkFail)onNetWorkFail
           onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",url,@"1_0/mobile/appLogin.do"];
    NSString*version=BunldVersion;//App版本号
    UIDevice *phoneDevice = [UIDevice currentDevice];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:account forKey:@"account"];
    [params setValue:password forKey:@"password"];
    [params setValue:@"iOS" forKey:@"systemType"];
    [params setValue:@"APPle" forKey:@"vendor"];
    [params setValue:phoneDevice.systemVersion forKey:@"systemVersion"];
    [params setValue:phoneDevice.model forKey:@"model"];
    [params setValue:version forKey:@"version"];
    [params setValue:@"cmg" forKey:@"appSign"];
    [params setValue:kAppType forKey:@"appType"];
    [params setValue:nil forKey:@"clientId"];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    [params setValue:deviceToken==nil?@"1":deviceToken forKey:@"umToken"];
    
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [DDUserInfoManager cleanUserInfo];
        [self analyseResult:resultDic bllSuccess:^{
            NSDictionary *dic = resultDic[@"data"];
            onLoginSuccess(dic);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
}


-(void)requestLogoutOnLogoutSuccess:(onLogoutSuccess)onLogoutSuccess
                          bllFailed:(bllFailed)bllFailed
                      onNetWorkFail:(onNetWorkFail)onNetWorkFail
                   onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_0/mobile/logout.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_GET apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
            
            [self analyseResult:resultDic bllSuccess:^{
               onLogoutSuccess();
           } bllFailed:^(NSString * _Nonnull msg) {
               bllFailed(msg);
           } isShow:NO];
           
       } onNetWorkFail:^(NSString * _Nonnull msg) {
           onNetWorkFail(msg);
       } onRequestTimeOut:^{
           onRequestTimeOut();
       }];

}

@end
