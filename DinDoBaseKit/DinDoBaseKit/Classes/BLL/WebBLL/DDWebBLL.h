//
//  DDWebBLL.h
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/23.
//

#import "BaseBLL.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDWebBLL : BaseBLL

+ (DDWebBLL *)sharedWebBLL;

// 上传图片成功
typedef void (^onUploadImgSuccess)(id responseObject);

- (void)uploadImgWithFiles:(UIImage *)files
                    ParDic:(NSDictionary *)parDic
                   Success:(onUploadImgSuccess)success
                 bllFailed:(bllFailed)bllFailed
             onNetWorkFail:(onNetWorkFail)onNetWorkFail
          onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


- (void)uploadImgWithImageArr:(NSArray *)imageArr
                      Success:(onUploadImgSuccess)success
                    bllFailed:(bllFailed)bllFailed
                onNetWorkFail:(onNetWorkFail)onNetWorkFail
             onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;



@end

NS_ASSUME_NONNULL_END
