//
//  DDImageUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片操作类
 */
@interface DDImageUtils : NSObject

/**
 初始化单例
 
 @return 单例对象
 */
+ (DDImageUtils *)sharedDDImageUtils;

/**
 颜色转图片
 
 @param color 颜色
 @return img
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 生成渐变色图片
 
 @param color color1
 @param color color2
 @param rect 大小
 @return img
 */
- (UIImage *)gradualImageWithColor:(UIColor *)color
                       secondColor:(UIColor *)color
                              rect:(CGRect)rect;

/**
 压缩图片
 
 @param sourceImage 压缩前img
 @return 压缩后img
 */
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

/**
 旋转图片
 
 @param aImage 原图
 @return 旋转后的图片
 */
- (UIImage *)imageWithRightOrientation:(UIImage *)aImage;



@end

NS_ASSUME_NONNULL_END
