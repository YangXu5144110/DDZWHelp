//
//  UIViewController+JNetWork.h
//  DDAPP
//
//  Created by 杨旭 on 2019/5/11.
//  Copyright © 2019年 点都科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JNetWork)
@property(nonatomic,strong,readonly)UINavigationController *myNavigationController;

+ (UIViewController*)currentViewController;


/**
 强制横屏方法
 横屏(如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏)
 @param fullscreen 屏幕方向
 */
- (void)setNewOrientation:(BOOL)fullscreen;
@end

NS_ASSUME_NONNULL_END
