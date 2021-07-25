//
//  DDDataUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 数据操作相关
 */
@interface DDDataUtils : NSObject
/**
 初始化单例
 
 @return 单例对象
 */
+ (DDDataUtils *)sharedDDDataUtils;

/**
 *  检测str是否有值
 *
 *  @param string 字符串
 *
 *  @return 0有值，1没有值
 */
- (BOOL)isBlankString:(id)string;


/**
 清除缓存
 */
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
