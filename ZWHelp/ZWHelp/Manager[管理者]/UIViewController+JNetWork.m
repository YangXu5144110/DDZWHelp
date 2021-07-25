//
//  UIViewController+JNetWork.m
//  DDAPP
//
//  Created by 杨旭 on 2019/5/11.
//  Copyright © 2019年 点都科技. All rights reserved.
//

#import "UIViewController+JNetWork.h"
#import "AppDelegate.h"

static const void *NetworkArrayKey = &NetworkArrayKey;

static const void *BlackViewControllerKey = &BlackViewControllerKey;

#define AtAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
//定义常量 必须是C语言字符串
static char *FullScreenAllowRotationKey = "FullScreenAllowRotationKey";

@implementation UIViewController (JNetWork)

+ (void)setNetworkArray:(NSArray <NSString *>*)networkArray {
    objc_setAssociatedObject(self, NetworkArrayKey, networkArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray <NSString *>*)networkArray {
    
    return objc_getAssociatedObject(self, NetworkArrayKey);
}



//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
/**
 是否允许横屏
 
 @return bool YES 允许 NO 不允许
 */
- (BOOL)shouldAutorotate1{
    BOOL flag = objc_getAssociatedObject(self, FullScreenAllowRotationKey);
    return flag;
}


/**
 屏幕方向
 
 @return 屏幕方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations1{
    //get方法通过key获取对象
    BOOL flag = objc_getAssociatedObject(self, FullScreenAllowRotationKey);
    if (flag) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation1{
    BOOL flag = objc_getAssociatedObject(self, FullScreenAllowRotationKey);
    if (flag) {
        return UIInterfaceOrientationLandscapeLeft;
    }else{
        return UIInterfaceOrientationPortrait;
    }
}

/**
 强制横屏方法
 
 @param fullscreen 屏幕方向
 */
- (void)setNewOrientation:(BOOL)fullscreen{
    AtAppDelegate.allowRotation = fullscreen;
    objc_setAssociatedObject(self, FullScreenAllowRotationKey,[NSNumber numberWithBool:fullscreen], OBJC_ASSOCIATION_ASSIGN);
    
    swizzleMethod([self class], @selector(shouldAutorotate), @selector(shouldAutorotate1));
    swizzleMethod([self class], @selector(supportedInterfaceOrientations), @selector(supportedInterfaceOrientations1));
    swizzleMethod([self class], @selector(preferredInterfaceOrientationForPresentation), @selector(preferredInterfaceOrientationForPresentation1));
    
    @autoreleasepool {
        if (fullscreen) {
            NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
            [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
            NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
            [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        }else{
            NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
            [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
            NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
            [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        }
    }
}

- (UINavigationController*)myNavigationController
{
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = ((UITabBarController*)self).selectedViewController.myNavigationController;
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}

@end
