//
//  LMWebProgressLayer.h
//  ZanXiaoQu
//
//  Created by user on 2018/1/24.
//  Copyright © 2018年 DianDu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

// 加载webview的进度条

@interface LMWebProgressLayer : CAShapeLayer
- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;  
@end
