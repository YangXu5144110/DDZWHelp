//
//  DDPromptUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 气泡提示
 */
@interface DDPromptUtils : NSObject


/**
 初始化单例

 @return 单例对象
 */
+ (DDPromptUtils *)sharedDDPromptUtils;

/**
 显示加载
 */
+(void)loading;

/**
 加载带文字

 @param msg msg
 */
+(void)loadingWithMsg:(NSString *)msg;

/**
 隐藏加载
 */
+ (void)hideLoading;

/**
 显示文本

 @param msg msg
 */
+ (void)promptMsg:(NSString *)msg;

/**
 带回调文字显示

 @param msg e文字
 @param promptCompletion 回调
 */
+ (void)promptMsg:(NSString *)msg
 promptCompletion:(void (^)(void))promptCompletion;

/**
 显示成功文本，带回调

 @param msg 文本
 @param promptCompletion 回调
 */
+ (void)promptSuccess:(NSString *)msg
     promptCompletion:(void (^)(void))promptCompletion;

/**
 显示错误文本

 @param msg 文本
 */
+ (void)promptError:(NSString *)msg;

/**
 显示成功文本
 
 @param msg 文本
 */
+ (void)promptSuccess:(NSString *)msg;


@end

NS_ASSUME_NONNULL_END
