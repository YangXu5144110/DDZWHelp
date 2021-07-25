//
//  YJProgressHUD.m
//  YJGeneralProject
//
//  Created by 叶炯 on 2017/4/12.
//  Copyright © 2017年 YeJiong. All rights reserved.
//

#import "YJProgressHUD.h"
#import "UIImage+GIF.h"
// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE    14.0f

@implementation YJProgressHUD

+ (instancetype)sharedHUD {
    static id hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[self alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        
    });
    return hud;
}

+ (void)showStatus:(YJProgressHUDStatus)status text:(NSString *)text {
    
    
    
    YJProgressHUD *HUD = [YJProgressHUD sharedHUD];
    [HUD hideAnimated:NO];
//    HUD.bezelView.color = [UIColor blackColor]; 
    //修改为绿色
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [APPTintColor colorWithAlphaComponent:0.9];
    //修改为绿色
    
    HUD.contentColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    [HUD setRemoveFromSuperViewOnHide:YES];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [HUD setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YJProgressHUD" ofType:@"bundle"];
    
    switch (status) {
            
        case YJProgressHUDStatusSuccess: {
            
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Success.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            HUD.customView = sucView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
        }
            break;
            
        case YJProgressHUDStatusError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Error.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            HUD.customView = errView;
            [HUD hideAnimated:YES afterDelay:1.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
        }
            break;
            
        case YJProgressHUDStatusLoading: {
                        
            HUD.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
            
        case YJProgressHUDStatusWaitting: {
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Warn.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });

        }
            break;
            
        case YJProgressHUDStatusInfo: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Info.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
        }
            break;
            
        default:
            break;
    }
}

+ (void)showMessage:(NSString *)text {
    [self showMessage:text afterDelay:1.0f];
}

+ (void)showWaiting:(NSString *)text {
    
    [self showStatus:YJProgressHUDStatusWaitting text:text];
}

+ (void)showError:(NSString *)text {
    
    [self showStatus:YJProgressHUDStatusError text:text];
}

+ (void)showSuccess:(NSString *)text {
    
    [self showStatus:YJProgressHUDStatusSuccess text:text];
}

+ (void)showLoading:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showStatus:YJProgressHUDStatusLoading text:text];
    });
}

+ (void)hideHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[YJProgressHUD sharedHUD] hideAnimated:NO];
    });
//    [[YJProgressHUD sharedHUD] setShowNow:NO];
//    [[YJProgressHUD sharedHUD] hideAnimated:NO];
}

+ (void)showMessage:(NSString *)text afterDelay:(NSTimeInterval )afterDelay{
    
    if (text.length <= 0) {
        return;
    }
    YJProgressHUD *HUD = [YJProgressHUD sharedHUD];
    HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [HUD showAnimated:YES];
    HUD.label.text = text;
    HUD.contentColor=[UIColor whiteColor];
    [HUD setMinSize:CGSizeZero];
    [HUD setMode:MBProgressHUDModeText];
    [HUD setRemoveFromSuperViewOnHide:YES];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [[YJProgressHUD sharedHUD] hideAnimated:YES];
    });
}

+ (void)showMessage:(YJProgressHUDStatus )status text:(NSString *)text hudAlpha:(CGFloat )hudAlpha imageName:(NSString *)imgName{
    CGFloat alpha = 1;
    if (hudAlpha < 1 && hudAlpha > 0) {
        alpha = hudAlpha;
    }
    YJProgressHUD *HUD = [YJProgressHUD sharedHUD];
    [HUD hideAnimated:NO];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [APPTintColor colorWithAlphaComponent:alpha];
    HUD.contentColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    [HUD setRemoveFromSuperViewOnHide:YES];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [HUD setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YJProgressHUD" ofType:@"bundle"];
    switch (status) {
            
        case YJProgressHUDStatusSuccess: {
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Success.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            HUD.customView = sucView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
        }
            break;
            
        case YJProgressHUDStatusError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Error.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            HUD.customView = errView;
            [HUD hideAnimated:YES afterDelay:1.0f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
        }
            break;
        case YJProgressHUDStatusLoading: {
//            HUD.mode = MBProgressHUDModeIndeterminate;
            HUD.mode = MBProgressHUDModeCustomView;
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"zlj_load" ofType:@"gif"];
            NSData  *data = [NSData dataWithContentsOfFile:filePath];
            UIImage *gifImage = [UIImage sd_imageWithGIFData:data];
//            UIImage *gifImage = [UIImage sd_imageWithGIFData:data];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            imageView.image = gifImage;
            HUD.customView = imageView;
        }
            break;
        case YJProgressHUDStatusWaitting: {
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Warn.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
            
        }
            break;
            
        case YJProgressHUDStatusInfo: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Info.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD hideAnimated:YES];
            });
        }
            break;
            
        default:
            break;
    }
}
@end
