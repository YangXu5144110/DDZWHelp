//
//  BaseBLL.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseBLL.h"
#import "UIImage+ColorImage.h"

@implementation BaseBLL

#pragma mark--根据不同类型进行网络请求
- (void)executeTaskWithDic:(NSDictionary *)requestDic
                   version:(NSInteger)version
                   signStr:(NSString *)signStr
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
                 onSuccess:(onSuccess)onSuccess
             onNetWorkFail:(onNetWorkFail)onNetWorkFail
          onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut{
    
    [NetWork dataTaskWithURLString:apiUrl
                           version:version
                           signStr:signStr
                     requestMethod:requestMethod
                        parameters:requestDic
                 completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error) {
        
        //请求超时
        if (error == URLResponseStatusErrorTimeout) {
            onRequestTimeOut();
            return;
        }
        //网络请求失败
        if (error == URLResponseStatusErrorNoNetwork) {
            onNetWorkFail(TIP_NETWORK_NO_CONNECTION);
            return;
        }
        
        if (responseObject == nil) {
            
            onNetWorkFail(TIP_RESPONSE_DATA_ERR);
            return;
        }
        //请求成功
        onSuccess(responseObject);
        
    }];
    
}



#pragma mark--AFN图片上传(文件)
- (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
             fileNameArr:(NSArray *)fileNameArr
                  parDic:(NSDictionary *)parDic
           uploadSuccess:(void (^)(id responseObject))uploadSuccess
           onNetWorkFail:(onNetWorkFail)onNetWorkFail
        onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    
    NSMutableDictionary *requestParams = [NetWork FormatRequestHTTPHeaderWithParams:parDic signStr:@""];
    
    AFHTTPSessionManager *manager = [NetWork sharedNetwork];
    
    manager.requestSerializer.timeoutInterval = NETWORKING_TIMEOUT_SECONDS;
    
    [manager POST:apiUrl parameters:requestParams headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < imageArr.count; i++) {
            NSData *imageData = [imageArr[i] compressWithMaxLength:1024 * 1024 * 15];
            
            [formData appendPartWithFileData:imageData
                                        name:[nameArr objectAtIndex:i]
                                    fileName:[fileNameArr objectAtIndex:i]
                                    mimeType:@"image/jepg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"++++%@", dict);
            uploadSuccess(dict);
        }
        else
        {
            uploadSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorTimedOut) {
            onRequestTimeOut();
        }
        else{
            onNetWorkFail(TIP_NETWORK_NO_CONNECTION);
        }
    }];
}


- (void)analyseResult:(NSDictionary *)resultDic
           bllSuccess:(bllSuccess)bllSuccess
            bllFailed:(bllFailed)bllFailed
               isShow:(BOOL)isShow {
    NSString *state = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"state"]];
    NSString *rspMsg = [resultDic objectForKey:@"msg"];
    
    
    if ([state boolValue]) {
        //成功的回调
        if (![[ToolBox ddDataUtils] isBlankString:rspMsg] && (isShow)) {
            [DDPromptUtils promptSuccess:rspMsg];
        }
        
        bllSuccess();
        
    } else {
        //失败回调
        bllFailed(rspMsg);
    }
    
}

@end
