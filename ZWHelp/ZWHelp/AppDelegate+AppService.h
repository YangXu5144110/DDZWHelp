//
//  AppDelegate+AppService.h
//  BusinessFine
//
//  Created by 杨旭 on 2019/8/29.
//  Copyright © 2019年 杨旭. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
//#import <BaiduMapAPI_Base/BMKMapManager.h>

//#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)<UNUserNotificationCenterDelegate>

/**
 友盟注册
 */
- (void)registerUmeng:(NSDictionary *)launchOptions;

/**
 键盘管理注册
 */
- (void)registerKeyboardManager;

/**
 Bugly注册
 */
- (void)registerBugly;

/**
 百度地图注册
*/
- (void)registerBMKMapManager;


@end

NS_ASSUME_NONNULL_END
