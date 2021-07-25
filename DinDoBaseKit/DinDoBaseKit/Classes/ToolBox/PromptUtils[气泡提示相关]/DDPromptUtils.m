//
//  DDPromptUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDPromptUtils.h"
#import <SVProgressHUD.h>
#import "YJProgressHUD.h"

@interface DDPromptUtils()

@property SVProgressHUD *HUD;

@end

@implementation DDPromptUtils
@synthesize HUD;

+ (DDPromptUtils *)sharedDDPromptUtils
{
    
    static DDPromptUtils *ddPromptUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddPromptUtils = [[DDPromptUtils alloc] init];
        
    });
    
    return ddPromptUtils;
}

+(void)loading{
    [YJProgressHUD showLoading:@""];
//    [SVProgressHUD showWithStatus:@"加载中..."];
//
//    [DDPromptUtils setSVProgressHUDStyle];
}

+ (void)loadingWithMsg:(NSString *)msg{
    [YJProgressHUD showLoading:msg];
//    [SVProgressHUD showWithStatus:msg];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [DDPromptUtils setSVProgressHUDStyle];
}

+ (void)hideLoading{
    
//    [SVProgressHUD dismiss];
//    [DDPromptUtils setSVProgressHUDStyle];
    [YJProgressHUD hideHUD];
}

+ (void)promptMsg:(NSString *)msg{
    
//    [DDPromptUtils setSVProgressHUDStyle];
//    [SVProgressHUD showInfoWithStatus:msg];
//    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
    [YJProgressHUD showMessage:msg];
}

+ (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [YJProgressHUD showMessage:msg afterDelay:PROMPT_TIME];
    
}

+ (void)promptSuccess:(NSString *)msg {
    [YJProgressHUD showSuccess:msg];
//    [DDPromptUtils setSVProgressHUDStyle];
//    [SVProgressHUD showSuccessWithStatus:msg];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
}

+ (void)promptSuccess:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    [YJProgressHUD showSuccess:msg];

//    [DDPromptUtils setSVProgressHUDStyle];
//    [SVProgressHUD showSuccessWithStatus:msg];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
//        promptCompletion();
//    }];
}

+ (void)promptError:(NSString *)msg{
    [YJProgressHUD showError:msg];
//    [DDPromptUtils setSVProgressHUDStyle];
//    [SVProgressHUD showErrorWithStatus:msg];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
}

+ (void)setSVProgressHUDStyle{
    
    CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (phoneVersion > 9) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"#656565"]];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    
}


@end
