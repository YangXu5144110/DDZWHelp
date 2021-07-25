//
//  DDWebViewModel.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/4.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDWebViewModel : NSObject

// 设置控制器
- (void)setViewCotroller:(UIViewController *)viewCotroller;

// 设置定位地址
- (void)setAddress:(NSString *)address;

// 设置web页面桥连接 oc与js进行交互
- (void)setWebView:(WKWebView*)webView bridge:(WKWebViewJavascriptBridge *)bridge;

// 设置左边item
- (void)setCreateLeftItemWithUrl:(NSString *)url;

// 设置右边item
- (void)setCreateRightItemWithUrl:(NSString *)url SearchTitle:(NSString *)searchTitle searchUrl:(NSString *)searchUrl;


@end

NS_ASSUME_NONNULL_END
