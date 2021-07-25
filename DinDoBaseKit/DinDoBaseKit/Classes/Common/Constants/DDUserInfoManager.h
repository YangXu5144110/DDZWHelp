//
//  DDUserInfoManager.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserInfoManager : NSObject

+ (DDUserInfoModel *) shareUserInfoManager;

/**  修改用户信息 */
+ (void)resetUserInfoMessageWithDic:(NSDictionary *)dic;
/** 保存用户信息 */
+ (void)saveUserInfoWithModel:(DDUserInfoModel *)entity;
/** 清空用户信息 */
+ (void)cleanUserInfo;
/** 获取用户信息 */
+ (DDUserInfoModel *)getUserInfo;
/** 判断用户登录状态 */
+ (BOOL)isLoad;
/** 重新登录 */
+ (void)relogin;

@end

NS_ASSUME_NONNULL_END
