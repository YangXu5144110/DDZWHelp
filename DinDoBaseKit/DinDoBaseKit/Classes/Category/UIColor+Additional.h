//
//  UIColor+Additional.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Additional)

+ (UIColor *) colorWithCustomR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
/// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *) colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END
