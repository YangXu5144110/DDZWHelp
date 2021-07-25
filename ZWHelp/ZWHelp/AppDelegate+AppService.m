//
//  AppDelegate+AppService.m
//  BusinessFine
//
//  Created by 杨旭 on 2019/8/29.
//  Copyright © 2019年 杨旭. All rights reserved.
//
#import "AppDelegate+AppService.h"
#import <IQKeyboardManager.h>
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
//#import <UMShare/UMShare.h>
#import <Bugly/Bugly.h>
//#import <AlipaySDK/AlipaySDK.h>
//#import <ImSDK.h>
#import <CYLTabBarController.h>
//#import "DDPayMentTools.h"
#import "DDWebViewController.h"
#import "DDWebManager.h"
#import <UIViewController+Nav.h>
@implementation AppDelegate (AppService)
- (void)registerUmeng:(NSDictionary *)launchOptions{
    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:UM_APP_KEY channel:@"App Store"];
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions
                                                       Entity:entity
                                            completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                if (granted) {
                                                    // 用户选择了接收Push消息
                                                }else{
                                                    // 用户拒绝接收Push消息
                                                }
                                            }];
//
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Wechat_APP_KEY appSecret:Wechat_APP_Secret redirectURL:nil];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APP_Id/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}
- (void)registerKeyboardManager{
//    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    IQKeyboardManager* manager = [IQKeyboardManager sharedManager];
    manager.toolbarDoneBarButtonItemText =@"完成";
    manager.enable=YES;
//    manager.toolbarManageBehaviour =IQAutoToolbarBySubviews;
    manager.shouldResignOnTouchOutside=YES;
    manager.shouldToolbarUsesTextFieldTintColor=NO;
    manager.enableAutoToolbar=YES;
    manager.shouldShowToolbarPlaceholder = YES;
    [manager setLayoutIfNeededOnUpdate:NO];
}

- (void)registerBugly {
    
    [Bugly startWithAppId:Bugly_Id];
}

- (void)registerBMKMapManager {
    
//    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
//    BOOL ret = [mapManager start:BMK_APP_KEY generalDelegate:self];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (@available(iOS 13.0, *)) {
        // 获取deviceToken
        if (![deviceToken isKindOfClass:[NSData class]]) return;
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        NSLog(@"deviceToken:%@",hexToken);
        NSData *token = [NSString dataFromHexString:hexToken];
        [UMessage registerDeviceToken:token];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:hexToken forKey:@"deviceToken"];
        [defaults setObject:token forKey:@"deviceTokenData"];
        [defaults synchronize];
    } else {
        
        [UMessage registerDeviceToken:deviceToken];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *deviceTokenStr =  [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<"withString: @""]
                                      stringByReplacingOccurrencesOfString: @">"withString: @""]
                                     stringByReplacingOccurrencesOfString: @" "withString: @""];
        [defaults setObject:deviceTokenStr forKey:@"deviceToken"];
        [defaults setObject:deviceToken forKey:@"deviceTokenData"];
        [defaults synchronize];
        
        NSLog(@"%@", deviceTokenStr);
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = deviceTokenStr;
    }
}
//iOS_10 以下
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    /** 必须加上，否则不会触发该方法 */
    if (userInfo) {
        completionHandler(UIBackgroundFetchResultNewData);
    }else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark 推送注册失败;
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark -- iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];//必须加这句代码 - 应用处于
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#pragma mark -- iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // 添加跳转详情页
    [self JPushNotificationShowDetailViewController:response.notification.request.content.userInfo];
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        [UMessage didReceiveRemoteNotification:userInfo];//必须加这句代码
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler();
}
///**
// *  最老的版本，最好也写上
// */
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return [[DDPayMentTools shareDDPayMentTools] dd_handleUrl:url];
//}
///**
// *  iOS 9.0 之前 会调用
// */
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [[DDPayMentTools shareDDPayMentTools] dd_handleUrl:url];
//}
///**
// *  iOS 9.0 以上（包括iOS9.0）
// */
//- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
//    return [[DDPayMentTools shareDDPayMentTools] dd_handleUrl:url];
//}
#pragma mark -- 推送进入详情界面
/**
 1. 当APP为关闭状态时，点击通知栏消息跳转到指定的页面。
 2. 当APP在后台运行时，点击通知栏消息跳转到指定的页面。
 3. 当APP在前台运行时，不会有通知栏提醒，也就不会跳转到指定界面。
 */
- (void)JPushNotificationShowDetailViewController:(NSDictionary *)userInfo{
    
//    [self receivePush:userInfo];
    if (userInfo == nil) {
        return;
    }
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *link = [NSString stringWithFormat:@"%@&",userInfo[@"url"]];
    NSString *url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
    DDWebViewController *webVC = [[DDWebViewController alloc] init];
    webVC.url = url;
    [rootVC.myNavigationController pushViewController:webVC animated:YES];
    
}


@end
