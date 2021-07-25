//
//  AppDelegate.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/21.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DDBaseTabBarController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) DDBaseTabBarController *tabBar;
@property (nonatomic,assign)BOOL allowRotation;//是否允许横屏


@end

