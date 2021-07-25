//
//  AppDelegate.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/21.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "AppDelegate.h"
#import "DDLoginViewController.h"
#import "AppDelegate+AppService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册友盟
    [self registerUmeng:launchOptions];
    [self registerKeyboardManager];
    [self registerBugly];
    [self registerBMKMapManager];
    NSLog(@"token是多少：：%@", [DDUserInfoManager getUserInfo].token);
    NSLog(@"沙盒路径 = %@", NSHomeDirectory());

    [self setRootViewController];

    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

- (void)setRootViewController
{
    
    if ([DDUserInfoManager isLoad] == YES) {
        // 已登录
        self.tabBar = [[DDBaseTabBarController alloc] init];
        self.tabBar.selectedIndex = 2;
        self.window.rootViewController = self.tabBar;
    } else {
        // 未登录
        DDLoginViewController *loginVC = [[DDLoginViewController alloc] init];
        DDBaseNavigationController *loginNavi = [[DDBaseNavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = loginNavi;
    }
    
}

@end
