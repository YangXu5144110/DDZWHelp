//
//  DDBaseTabBarController.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"


NS_ASSUME_NONNULL_BEGIN

@interface DDBaseTabBarController : CYLTabBarController<UITabBarControllerDelegate>

/**
 登录重新加载VC

 @param rVC 重新加载的VC
 */
- (void)loginReloadViewController:(NSArray <UIViewController *>*)rVC;

@end

NS_ASSUME_NONNULL_END
