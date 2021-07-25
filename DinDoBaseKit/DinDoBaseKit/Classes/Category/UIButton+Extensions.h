//
//  UIButton+Extensions.h
//  峰哥cells
//
//  Created by silence on 2017/9/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    ButtonImgViewStyleTop,
    ButtonImgViewStyleLeft,
    ButtonImgViewStyleBottom,
    ButtonImgViewStyleRight,
} ButtonImgViewStyle;

@interface UIButton (Extensions)


/**
 上部分是图片，下部分是文字

 @param space 间距
 */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space;


/**
 左边是文字，右边是图片（和原来的样式翻过来）

 @param space 间距
 */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space;


/**
 设置角标的个数（右上角）

 @param badgeValue <#badgeValue description#>
 */
- (void)setBadgeValue:(NSInteger)badgeValue;


/**
 设置 按钮 图片所在的位置
 
 @param style   图片位置类型（上、左、下、右）
 @param size    图片的大小
 @param space 图片跟文字间的间距
 */
- (void)setImgViewStyle:(ButtonImgViewStyle)style imageSize:(CGSize)size space:(CGFloat)space;

/** zlj  -- copy 原项目 方法 08-21
 上图下字按钮,
 titleTopImgInterval 标题距图片距离
 imgTopInterval 图片据顶部距离
 */
-(void)customBtnStyleUpImageDownTextWithText:(NSString*)text fontSize:(CGFloat)font img:(UIImage*)imag imgTopInterval:(CGFloat)imgTopInterval titleTopImgInterval:(CGFloat)titleTopImgInterval btnSize:(CGSize)btnSize;

@end
