//
//  YXCustomAlertActionView.h
//  DDBLifeShops
//
//  Created by 杨旭 on 2019/3/13.
//  Copyright © 2019年 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,AlertViewType) {
    AlertText,          //提示文字
    AlertTextField,     //提示输入框
    AlertTextView,      //提示文本输入框
    AlertTwoTextField,  //提示修改地址
    AlertTextTable,     //提示列表
};

typedef void(^sureBlock)(NSString *string);
typedef void(^cancelBlock)(void);
typedef void(^hideBlock)(void);


@interface YXCustomAlertActionView : UIView


/** 确认按钮*/
@property (nonatomic ,strong) UIButton *sureBtn;

@property (nonatomic ,strong) NSString *sureStr;
@property (nonatomic ,strong) NSString *placeholder;
@property (nonatomic ,assign) NSInteger limitEnterCount;
@property (nonatomic ,strong) NSArray  *listArr;


//初始化设置样式
- (instancetype)initWithFrame:(CGRect)frame ViewType:(AlertViewType)type Title:(NSString *)title Message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle ;
/**
 弹出视图
 */
-(void)showAnimation;

/**
 开始倒计时关闭
 */
- (void)startCountDown;


/**
 点击确定按钮回调
 */
@property (nonatomic,copy)sureBlock sureClick;


/**
 点击取消按钮回调
 */
@property (nonatomic,copy)cancelBlock  cancelClick;
/**
 点击背景按钮回调
 */
@property (nonatomic,copy)hideBlock  hideClick;


@end

NS_ASSUME_NONNULL_END
