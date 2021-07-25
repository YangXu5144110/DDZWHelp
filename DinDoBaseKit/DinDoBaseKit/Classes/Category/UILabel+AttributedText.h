//
//  UILabel+AttributedText.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AttributedText)

/**
 获取富文本

 @param fullText 完整text
 @param replaceText 需要替换的text
 @param color 替换的颜色
 @param font 替换的文字大小
 @return 富文本
 */
+ (NSMutableAttributedString *)getAttributedStringWithFullText:(NSString *)fullText
                                                   replaceText:(NSString *)replaceText
                                                     textColor:(UIColor *)color
                                                      textFont:(UIFont *)font;
/**
 *  按照自定义尺寸大小，对字体间距设置px像素
 */
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withSpacing:(CGFloat)spacing ImageName:(NSString *)imageName;


@end

NS_ASSUME_NONNULL_END
