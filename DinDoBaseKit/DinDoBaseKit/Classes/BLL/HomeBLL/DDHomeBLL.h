//
//  DDHomeBLL.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import "BaseBLL.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeBLL : BaseBLL

+ (DDHomeBLL *)sharedHomeBLL;


// 查询网格成功
typedef void (^onGridInfoSuccess)(NSDictionary *dic);



/**
 查询网格
 
 @param Id 主键id
 @param onGridInfoSuccess 成功
 @param bllFailed 失败
 @param onNetWorkFail 网络错误
 @param onRequestTimeOut 超时
 */
- (void)queryGridInfoWithId:(NSString *)Id
          onGridInfoSuccess:(onGridInfoSuccess)onGridInfoSuccess
                  bllFailed:(bllFailed)bllFailed
              onNetWorkFail:(onNetWorkFail)onNetWorkFail
           onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

/// 获取消息个数
/// @param onGridInfoSuccess 成功
/// @param bllFailed 失败
/// @param onNetWorkFail 网络错误
/// @param onRequestTimeOut 超时
- (void)queryUnreadCountnSuccess:(onGridInfoSuccess)onGridInfoSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;




@end

NS_ASSUME_NONNULL_END
