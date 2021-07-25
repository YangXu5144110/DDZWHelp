//
//  NetWork.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

+ (NetWork *)sharedSelf {
    
    static NetWork *network = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        network = [[self alloc] init];
//        network.taskArray = [NSMutableArray array];
    });
    
    return network;
    
}
+ (void)dd_hasNetwork:(void(^)(bool has))hasNet{
    //创建网络监听对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                hasNet(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                hasNet(YES);
                [self addOutLineOpenDoor];
                break;
        }
    }];
    //结束监听
    [manager stopMonitoring];
}
+ (void)addOutLineOpenDoor{
//    NSArray *tem = [[NSUserDefaults standardUserDefaults] objectForKey:@"outLineOpenDoor"];
//    NSMutableArray *outLine = [[NSMutableArray alloc]initWithArray:tem];
//
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableIndexSet *set = [NSMutableIndexSet new];
//    for (NSInteger i = 0; i < outLine.count; i ++) {
//        dispatch_group_enter(group);
//        [[WGIntelligentBLL sharedIntelligentBLL] addOpenDoorOutLineRecodeParm:outLine[i] success:^(NSString * _Nonnull msg) {
//            [set addIndex:i];
//            dispatch_group_leave(group);
//        } bllFailed:^(NSString * _Nonnull msg) {
//            dispatch_group_leave(group);
//
//        } onNetWorkFail:^(NSString * _Nonnull msg) {
//            dispatch_group_leave(group);
//
//        } onRequestTimeOut:^{
//            dispatch_group_leave(group);
//
//        }];
//    }
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        // 等前面的异步操作都执行完毕后，回到主线程.
//        if (set.count) {
//            [outLine removeObjectsAtIndexes:set];
//            [[NSUserDefaults standardUserDefaults] setObject:outLine forKey:@"outLineOpenDoor"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//    });

}
+ (AFHTTPSessionManager *)sharedNetwork{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        //过滤value为空的键值
        [serializer setRemovesKeysWithNullValues:YES];
        
        serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                             @"text/plain",
                                             @"application/json",
                                             @"image/jpeg",
                                             @"image/png",
                                             @"application/octet-stream",
                                             @"text/json",
                                             @"text/javascript", nil];
        manager.responseSerializer = serializer;
        //JSON请求
        AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
        manager.requestSerializer = request;
        manager.requestSerializer.timeoutInterval = 20;

    });
    
    return manager;
}


+ (void)dataTaskWithURLString:(NSString *_Nonnull)urlStr
                      version:(NSInteger)version
                      signStr:(NSString *)signStr
                requestMethod:(NSString *_Nonnull)requestMethod
                   parameters:(NSDictionary *_Nullable)params
            completionHandler:(void (^_Nonnull)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error))completionHandler
{
    
    AFHTTPSessionManager *manager = [self sharedNetwork];
    
    NSMutableDictionary *requestParams = [self FormatRequestHTTPHeaderWithParams:params signStr:signStr];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:requestMethod URLString:urlStr parameters:requestParams error:nil];
    
    [request setTimeoutInterval:NETWORKING_TIMEOUT_SECONDS];
    NSLog(@"----%@", urlStr);
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {


        URLResponseStatusEnum status = [self responseStatusWithError:error];
        
        if (responseObject != nil) {
            
            NSError *parseError = nil;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&parseError];
            
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"异常接口--%@", urlStr);

            NSLog(@"%@", jsonStr);
        }
        
        if (error.code != NSURLErrorCancelled) {
            
            //校验网络请求返回的数据
            if (status == URLResponseStatusSuccess) {
                completionHandler?completionHandler(response,responseObject,status):nil;
                
            }else{
                
                completionHandler?completionHandler(response,nil,status):nil;
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    //获取http code
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    
                    if (httpResponse.statusCode == 401) {
                        // 重新登录
                        NSLog(@"%@--401---", urlStr);

                        [DDPromptUtils promptMsg:@"您的账号在别处登录，请重新登"];
                        [[UIViewController currentViewController] relogin];
                    }
                }
            }
        }
        
        
    }];
    
    
    [dataTask resume];
}



//取消请求
+ (void)cancelAllNetWorkRequest
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.operationQueue cancelAllOperations];
}


#pragma mark - private methods
+ (URLResponseStatusEnum)responseStatusWithError:(NSError *)error
{
    if (error) {
        URLResponseStatusEnum result = URLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            
            result = URLResponseStatusErrorTimeout;
        }
        
        return result;
        
    } else {
        
        return URLResponseStatusSuccess;
    }
}


/**
 设置请求头cookie

 @param params  参数
 @param signStr 签名字符串
 */
+ (NSMutableDictionary *)FormatRequestHTTPHeaderWithParams:(NSDictionary *)params
                                                   signStr:(NSString *)signStr
{
    
 
    NSMutableDictionary *dicss = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    // 公共参数
    [dicss setValue:[DDUserInfoManager getUserInfo].token forKey:@"token"];
    [dicss setValue:[DDUserInfoManager getUserInfo].userId forKey:@"userId"];
    [dicss setValue:[DDUserInfoManager getUserInfo].userName forKey:@"userName"];
    [params setValue:@"cmg" forKey:@"appSign"];
    [params setValue:kAppType forKey:@"appType"];
    
    //设置http请求头
    AFHTTPSessionManager *manager = [self sharedNetwork];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

//    [manager.requestSerializer setValue:kAppType forHTTPHeaderField:@"appType"];
 
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"cross"];
    // 将requestTime存到请求头中
    NSString *timeStamp = [[ToolBox ddDateUtils] getCurrentTimeStr];
    [manager.requestSerializer setValue:timeStamp forHTTPHeaderField:@"requestTime"];
    
    //进行MD5转换
    NSString *signString = [NSString getSignStringFromDic:dicss];
    NSString *signKey = [NSString stringWithFormat:@"%@&key=%@",signString,@"dd2007"];
    NSString *signMd5 = [NSString getMD5StringFromStr:signKey];
    

    // 将sign存到请求头中
    if ([[ToolBox ddDataUtils] isBlankString:signStr]) {

        [manager.requestSerializer setValue:signMd5 forHTTPHeaderField:@"sign"];
    } else {
        
        [manager.requestSerializer setValue:signStr forHTTPHeaderField:@"sign"];
    }


    return dicss;
}



@end
