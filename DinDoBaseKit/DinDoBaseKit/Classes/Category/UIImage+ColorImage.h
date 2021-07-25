//
//  UIImage+ColorImage.h
//  ZanXiaoQu
//
//  Created by mac on 2017/12/1.
//  Copyright © 2017年 DianDu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 旋转图片

 @param aImage 原图
 @return 旋转后的图片
 */
+ (UIImage *)imageWithRightOrientation:(UIImage *)aImage;
+ (UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular;
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength;
+(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
@end
