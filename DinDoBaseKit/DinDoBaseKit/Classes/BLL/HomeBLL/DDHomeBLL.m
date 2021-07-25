//
//  DDHomeBLL.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDHomeBLL.h"

@implementation DDHomeBLL

+ (DDHomeBLL *)sharedHomeBLL
{
    static DDHomeBLL *homeBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        homeBLL = [[self alloc] init];
    });
    
    return homeBLL;
}

- (void)queryGridInfoWithId:(NSString *)Id
          onGridInfoSuccess:(onGridInfoSuccess)onGridInfoSuccess
                  bllFailed:(bllFailed)bllFailed
              onNetWorkFail:(onNetWorkFail)onNetWorkFail
           onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_0/mobile/queryGridInfo.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:Id forKey:@"id"];
    
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSDictionary *dic = resultDic[@"data"];
            onGridInfoSuccess(dic);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
}
- (void)queryUnreadCountnSuccess:(onGridInfoSuccess)onGridInfoSuccess bllFailed:(bllFailed)bllFailed onNetWorkFail:(onNetWorkFail)onNetWorkFail onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_0/mobile/message/queryUnreadCount.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSDictionary *dic = resultDic[@"data"];
            onGridInfoSuccess(dic);
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
