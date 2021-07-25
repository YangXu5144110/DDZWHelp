//
//  DinDoBaseKit.h
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/21.
//

#ifndef DinDoBaseKit_h
#define DinDoBaseKit_h

#pragma mark ----- 引用库
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <DateTools/DateTools.h>
#import <MJExtension/MJExtension.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import <Masonry/Masonry.h>
#import "UIScrollView+EmptyDataSet.h"

#pragma mark ----- 引用基类
#import <DDBaseTableViewCell.h>
#import <DDBaseViewController.h>
#import <DDBaseTabBarController.h>
#import <DDBaseNavigationController.h>
#import <DDBaseModel.h>

#pragma mark ----- 引用通用类
#import "NetWork.h"
#import "UIViewController+CommonFunc.h"
#import "UIColor+Additional.h"
#import "UIButton+Extensions.h"
#import "UILabel+AttributedText.h"
#import "NSString+RegularExpression.h"
#import "NSString+Additional.h"
#import "UIView+frameAdjust.h"
#import "YXCustomAlertActionView.h"
#import "TotastView.h"
#import "YJProgressHUD.h"
#import "DDPromptUtils.h"
#import "LTLimitTextField.h"
#import "ToolBox.h"

#pragma mark ----- 引用工具类
#import "ToolBox.h"
#import "UIViewController+KNSemiModal.h"
#import "DDUserInfoModel.h"
#import "DDUserInfoManager.h"
#import "DDCacheManager.h"

#pragma mark ----- 引用宏定义
#import "Color.h"
#import "Config.h"
#import "AccountConfig.h"
#import "Interface.h"
#import "TipMsg.h"
#import "TextFont.h"

#define LBXScan_Define_Native  //下载了native模块
#define LBXScan_Define_UI     //下载了界面模块

#endif
