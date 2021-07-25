//
//  BaseBLL.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseBLL : NSObject

//请求成功
typedef void (^onSuccess)(NSDictionary *resultDic);
//定义网络请求失败处理
typedef void (^onNetWorkFail)(NSString *msg);
//网络请求超时
typedef void (^onRequestTimeOut)(void);


typedef void (^ bllSuccess)(void);
typedef void (^ bllFailed)(NSString *msg);



/**
 执行网络请求

 @param requestDic 请求数据
 @param version 接口版本号
 @param signStr 签名字符串
 @param requestMethod 请求方式
 @param apiUrl 请求接口地址
 @param onSuccess 成功
 @param onNetWorkFail 失败
 @param onRequestTimeOut 超时
 */
- (void)executeTaskWithDic:(NSDictionary * _Nullable)requestDic
                   version:(NSInteger)version
                   signStr:(NSString *)signStr
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
                 onSuccess:(onSuccess)onSuccess
             onNetWorkFail:(onNetWorkFail)onNetWorkFail
          onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
 上传图片请求

 @param apiUrl 请求地址
 @param version q接口版本号
 @param imageArr img数组
 @param nameArr img参数名数组
 @param parDic 请求参数
 @param uploadSuccess 成功
 @param onNetWorkFail 失败
 @param onRequestTimeOut 超时
 */
- (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
             fileNameArr:(NSArray *)fileNameArr
                  parDic:(NSDictionary *)parDic
           uploadSuccess:(void (^)(id responseObject))uploadSuccess
           onNetWorkFail:(onNetWorkFail)onNetWorkFail
        onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
 请求回调后的数据分析

 @param resultDic 网络请求返回的Dic
 @param bllSuccess 分析成功回调
 @param bllFailed 分析失败回调
 @param isShow 是否显示成功的提示文字
 */
- (void)analyseResult:(NSDictionary *)resultDic
           bllSuccess:(bllSuccess)bllSuccess
            bllFailed:(bllFailed)bllFailed
               isShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
