//
//  DDForgetViewController.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/14.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 注册/忘记密码

 */
typedef NS_ENUM(NSUInteger, RegistShowType) {
    RegistShowType_Forget,  //忘记密码
    RegistShowType_LoginPsd,//修改登录密码
};

@interface DDForgetViewController : DDBaseViewController

//页面显示类型
@property (nonatomic, assign) RegistShowType registType;

@end

NS_ASSUME_NONNULL_END
