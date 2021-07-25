//
//  DDWebViewController.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDWebViewController : DDBaseViewController

/// 传入标题
@property (strong, nonatomic)  NSString *titleStr;

/// 传入url地址
@property (strong, nonatomic)  NSString *url;

/// 传入搜索标题
@property (strong, nonatomic)  NSString *searchTitle;

/// 传入搜索url地址
@property (strong, nonatomic)  NSString *searchUrl;
@end

NS_ASSUME_NONNULL_END
