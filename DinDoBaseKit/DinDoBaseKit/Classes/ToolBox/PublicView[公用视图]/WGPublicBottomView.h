//
//  WGPublicBottomView.h
//  DDLife
//
//  Created by wanggang on 2019/7/23.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 公用底部按钮
 */
@interface WGPublicBottomView : UIView

@property (nonatomic ,copy)void(^clickButtonBlock)(NSInteger index);

@property (nonatomic ,strong)  id title;
@property (nonatomic ,assign) CGFloat font;
@property (nonatomic ,strong) UIColor *backColor;

@end

NS_ASSUME_NONNULL_END
