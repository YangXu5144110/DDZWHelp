//
//  DDUserInfoManager.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDUserInfoManager.h"
#define KEY @"USERINFO"

static DDUserInfoModel *userInfoModel = nil;
@implementation DDUserInfoManager

+ (DDUserInfoManager *)shareUserInfoManager {
    static DDUserInfoManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DDUserInfoManager alloc] init];
    });
    return manager;
}

/** 保存用户信息 */
+ (void)saveUserInfoWithModel:(DDUserInfoModel *)entity {
    //NSUserDefaults 继承于NSObject, 单例模式设计, 存储信息采用键值对的形式
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:entity];
    [userDefault setObject:data forKey:KEY];
    [userDefault synchronize];
    
}
/** 清空用户信息 */
+ (void)cleanUserInfo {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:KEY];
    [userDefault synchronize];
    userInfoModel = nil;
    
}
/** 获取用户信息 */
+ (DDUserInfoModel *)getUserInfo {
    
    if (!userInfoModel) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefault objectForKey:KEY];
        if (data) {
            userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } else {
            userInfoModel = nil;
        }
    }
    return userInfoModel;
    
    
}
/** 判断用户登录状态 */
+ (BOOL)isLoad {
    
    if ([DDUserInfoManager  getUserInfo] == nil) {
        return NO;
    } else {
        return YES;
    }
    
}

/**  修改用户信息 */
+ (void)resetUserInfoMessageWithDic:(NSDictionary *)dic {
    
    DDUserInfoModel *model = [DDUserInfoManager getUserInfo];
    NSString *key = [dic allKeys].firstObject;
    
    if ([key isEqualToString:@"headImg"]) {
        model.headImg = dic[@"headImg"];
    }
//
//    if ([key isEqualToString:@"nickName"]) {
//        model.nickName = dic[@"nickName"];
//    }
//
    if ([key isEqualToString:@"sex"]) {
        model.sex = [dic[@"sex"] integerValue];
    }

//
//    if ([key isEqualToString:@"address"]) {
//        model.address = dic[@"address"];
//    }
//

    [DDUserInfoManager saveUserInfoWithModel:model];
    
}

/**  重新登录 */
+ (void)relogin{
    
//    [DDUserInfoManager cleanUserInfo];
//    [[DDCacheManager shareManager] removeDataFile];
//    [controller.navigationController popToRootViewControllerAnimated:NO];
//    Class class = NSClassFromString(@"DDLoginViewController");
//    DDBaseViewController *loginVC = [[class alloc] init];
//    DDBaseNavigationController *loginNavi = [[DDBaseNavigationController alloc] initWithRootViewController:loginVC];
//    [UIApplication sharedApplication].keyWindow.rootViewController = loginNavi;
    
}

@end
