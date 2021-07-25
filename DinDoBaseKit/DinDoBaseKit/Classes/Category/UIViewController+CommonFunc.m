//
//  UIViewController+CommonFunc.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UIViewController+CommonFunc.h"
@implementation UIViewController (CommonFunc)

#pragma- 网络请求提示器
- (void)loading{
    
    [self endViewEditing];
//    [DDPromptUtils loading];
}

- (void)loadingMsg:(NSString *)msg {
    
//    [DDPromptUtils loadingWithMsg:msg];
}

//结束页面编辑
- (void)endViewEditing
{
    [self.view endEditing:YES];
}

#pragma 隐藏网络请求指示器
- (void)hideLoading {
    
//    [DDPromptUtils hideLoading];
    [self hideStatusLoading];
}

#pragma mark - 气泡提示
//气泡提示
- (void)promptMsg:(NSString *)msg{
    
    [self hideStatusLoading];
    [self.view endEditing:YES];
    if (msg.length > 0) {// zlj -- 08-14
        
//        [DDPromptUtils promptMsg:msg];
    }
}

//气泡提示 with block
- (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [self hideStatusLoading];
    
//    [DDPromptUtils promptMsg:msg promptCompletion:^{
//        promptCompletion();
//    }];
    
}

- (void)promptMsgOnWindow:(NSString *)msg{
    
    [self hideStatusLoading];
    [self.view endEditing:YES];
    
//    [DDPromptUtils promptMsg:msg];
}

- (void)promptReqSuccess:(NSString *)msg{
    
//    [DDPromptUtils promptSuccess:msg promptCompletion:^{}];
    
}

//请求超时
- (void)promptRequestTimeOut{
    
    [self hideStatusLoading];
//    [self promptMsg:TIP_NETWORK_TIMEOUT];
    
}

//网络请求失败
- (void)promptNetworkFailed{
    
//    [self promptMsg:TIP_NETWORK_NO_CONNECTION];
}

#pragma mark - 状态栏网络请求
//显示状态栏网络请求
- (void)showStatusLoading{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//隐藏状态栏网络请求
- (void)hideStatusLoading{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)addViewEndEditTap{
    //点击空白处取消编辑状态
//    UITapGestureRecognizer *TapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endViewEditing)];
//    TapGesturRecognizer.delegate = self;
//    TapGesturRecognizer.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:TapGesturRecognizer];
}

- (void)showAlertWithMessage:(NSString *)message
                 withConfirm:(NSString *)confirm
                      Handle:(void(^)(UIAlertAction * _Nonnull action))handle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:confirm style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        handle(action);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:alert];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //设置只允许视频播放界面可以旋转，其他只能竖屏
    if ([self isKindOfClass:NSClassFromString(@"AVFullScreenViewController")]) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}



- (void)relogin {
    
    [DDUserInfoManager cleanUserInfo];
    [[DDCacheManager shareManager] removeDataFile];
    [self.navigationController popToRootViewControllerAnimated:NO];
    Class class = NSClassFromString(@"DDLoginViewController");
    DDBaseViewController *loginVC = [[class alloc] init];
    DDBaseNavigationController *loginNavi = [[DDBaseNavigationController alloc] initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginNavi;
    
}


+ (UIViewController*)currentViewController {
    
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (1) {
        
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

@end


@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}
@end
