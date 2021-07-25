//
//  BaseView.m
//  ZanXiaoQu
//
//  Created by 杨旭 on 2019/7/5.
//  Copyright © 2019年 DianDu. All rights reserved.
//

#import "DDBaseView.h"

@implementation DDBaseView

/**
 * 获取UIView对象所属的ViewController
 */
- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *) nextResponder;
        }
    }
    return nil;
}

@end
