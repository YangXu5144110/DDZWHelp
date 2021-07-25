//
//  DDDateUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 时间格式化类
 */
@interface DDDateUtils : NSObject

/**
 初始化单例
 
 @return 单例对象
 */
+ (DDDateUtils *)sharedDDDateUtils;


/**
 获取当前时间戳
 */
- (NSString *)getCurrentTimeStr;

/**
 计算两个时间间隔
 
 @param nowDateStr 开始时间
 @param deadlineStr 结束时间
 @return 返回字符串
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;

/**
 时间戳转string
 
 @param timestamp 时间戳
 @param format 时间格式
 @return 返回时间string
 */
+ (NSString *)timestampToString:(NSInteger)timestamp  withFormat:(NSString *)format;


//获取当前的时间
-(NSString*)getCurrentTimes;
//获取当前的时间自定义格式
-(NSString*)getCurrentTimesWithFormat:(NSString *)format;
// 字符串转时间戳
+ (NSString *)getTimeStrWithString:(NSString *)str;
// 字符串转自定义格式时间戳
+ (NSString *)getTimeStrWithString:(NSString *)str Format:(NSString *)format;
// 字符串转时间戳根据小时
+ (NSString *)getTimeStrWithString:(NSString *)str withHour:(NSString *)hour;
//获取当前时间戳字符串
+ (NSString *)currentTimeStr;
//字符串转时间
+ (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;
///获取中文的时间字符串
+ (NSString *)getTimeChinese:(NSString *)dateString;
//返回星期几
- (NSString*)getWeekdayStringFromDate;

+ (BOOL)compareDate:(NSString*)sDate withDate:(NSString*)bDate;

/**
 是否可以弹新人红包

 @return  是否可以弹新人红包
 */
+ (BOOL)isCanPopNewPeopleRedPacket;

@end

NS_ASSUME_NONNULL_END
