//
//  NetWork.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWork : NSObject

+ (AFHTTPSessionManager *_Nonnull)sharedNetwork;

/**
 检测网络状态

 @param hasNet 是否有网
 */
+ (void)dd_hasNetwork:(void(^)(bool has))hasNet;

//定义网络请求失败类型
typedef NS_ENUM(NSUInteger, URLResponseStatusEnum)
{
    URLResponseStatusSuccess, // 作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于返回的数据是否完整，由上层的controller来决定。
    URLResponseStatusErrorTimeout, // 超时
    URLResponseStatusErrorNoNetwork, // 默认除了超时以外的错误都是无网络错误
    URLResponseStatusFailed  //请求失败
};



/**
 网络请求封装
 
 @param urlStr              接口地址
 @param version             版本号
 @param signStr             签名字符串
 @param requestMethod       请求方式
 @param params              请求参数
 @param completionHandler   请求回调
 */
+ (void)dataTaskWithURLString:(NSString *_Nonnull)urlStr
                      version:(NSInteger)version
                      signStr:(NSString *)signStr
                requestMethod:(NSString *_Nonnull)requestMethod
                   parameters:(NSDictionary *_Nullable)params
            completionHandler:(void (^_Nonnull)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error))completionHandler;



/**
 设置请求头cookie
 
 @param params  参数
 @param signStr 签名字符串
 */
+ (NSMutableDictionary *)FormatRequestHTTPHeaderWithParams:(NSDictionary *)params
                                                   signStr:(NSString *)signStr;

/**
 取消请求
 */
+ (void)cancelAllNetWorkRequest;

@end

NS_ASSUME_NONNULL_END
