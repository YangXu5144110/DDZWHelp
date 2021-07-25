//
//  DDUserBLL.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDUserBLL.h"

@implementation DDUserBLL

+ (DDUserBLL *)sharedUserBLL
{
    
    static DDUserBLL *userBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userBLL = [[self alloc] init];
    });
    
    return userBLL;
}

- (void)uploadHeadImgWithImage:(UIImage *)image
                       Success:(onUploadHeadImgSuccess)success
                     bllFailed:(bllFailed)bllFailed
                 onNetWorkFail:(onNetWorkFail)onNetWorkFail
              onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_0/mobile/user/uploadHeadImg.do"];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //上传的参数名
    NSString *name = [NSString stringWithFormat:@"%@%d", [NSDate date], arc4random() % 100];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
    
    [self uploadWithapiUrl:urlStr version:1 imageArr:@[image] nameArr:@[@"headImg"] fileNameArr:@[fileName] parDic:dataDic uploadSuccess:^(id  _Nonnull responseObject) {
        [self analyseResult:responseObject bllSuccess:^{
            success(responseObject);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
    
}


- (void)updatePersonInfoWithSex:(NSString *)sex
             onUpdateSexSuccess:(onUpdateSexSuccess)onUpdateSexSuccess
                      bllFailed:(bllFailed)bllFailed
                  onNetWorkFail:(onNetWorkFail)onNetWorkFail
               onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_0/mobile/user/updatePersonInfo.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:sex forKey:@"sex"];

    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            onUpdateSexSuccess();
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}


- (void)updatePwdWithOldPassword:(NSString *)oldPassword
                     newPassword:(NSString *)newPassword
              onUpdatePwdSuccess:(onUpdatePwdSuccess)onUpdatePwdSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_0/mobile/user/updatePassword.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:oldPassword forKey:@"oldPassword"];
    [params setValue:newPassword forKey:@"newPassword"];

    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            onUpdatePwdSuccess();
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}

- (void)queryShareWithUserId:(NSString *)userId
              OnShareSuccess:(onShareSuccess)onShareSuccess
                   bllFailed:(bllFailed)bllFailed
               onNetWorkFail:(onNetWorkFail)onNetWorkFail
            onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/1_6/mobile/phoneBook/QueryShare.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"userId"];
    
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSDictionary *dic = resultDic[@"data"];
            onShareSuccess(dic);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
    
    
}


- (void)updateShareWithUserId:(NSString *)userId
                        State:(NSString *)state
        onUpdateShareSuccess:(onUpdateShareSuccess)onUpdateShareSuccess
                   bllFailed:(bllFailed)bllFailed
               onNetWorkFail:(onNetWorkFail)onNetWorkFail
             onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/1_6/mobile/phoneBook/updateShare.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"userId"];
    [params setValue:state forKey:@"state"];
    
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            onUpdateShareSuccess();
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
