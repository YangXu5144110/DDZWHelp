//
//  DDDateUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDDateUtils.h"

@implementation DDDateUtils

+ (DDDateUtils *)sharedDDDateUtils
{
    
    static DDDateUtils *ddDateUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddDateUtils = [[DDDateUtils alloc] init];
        
    });
    
    return ddDateUtils;
}


- (NSString *)getCurrentTimeStr
{
    //获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time=[date timeIntervalSince1970]*1000;
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}
/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}



+ (NSString *)timestampToString:(NSInteger)timestamp  withFormat:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    //NSDate转NSString
    return [dateFormatter stringFromDate:date];
}

//获取当前的时间

- (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

-(NSString*)getCurrentTimesWithFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:format];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

//字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

+ (NSString *)getTimeStrWithString:(NSString *)str Format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:format]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}



//字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str withHour:(NSString *)hour{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //设定时间的格式
    
    NSString *str1 = [str stringByReplacingCharactersInRange:NSMakeRange(11, 8) withString:[NSString stringWithFormat:@"%@:00:00",hour]];
    
    NSDate *tempDate = [dateFormatter dateFromString:str1];//将字符串转换为时间对象
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

//获取当前时间戳字符串
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format?:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
+ (NSString *)getTimeChinese:(NSString *)dateString{
    NSDate *date = [DDDateUtils stringToDate:dateString withDateFormat:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 HH:mm"]; //设定时间的格式
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}
//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}
//返回星期几
- (NSString*)getWeekdayStringFromDate
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    return [weekdays objectAtIndex:theComponents.weekday];
}


+(BOOL)compareDate:(NSString*)sDate withDate:(NSString*)bDate{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc]init];
    NSDate *dt2 = [[NSDate alloc]init];
    dt1 = [df dateFromString:sDate];
    dt2 = [df dateFromString:bDate];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result){
            
        case NSOrderedAscending:
            return  YES;//bDate比sDate大
            break;
            
        case NSOrderedDescending:
            return  NO;//bDate比sDate小
            break;
            
        case NSOrderedSame:
            return  YES;//bDate=sDate
            break;
        default: return NO;break;
    }
    return NO;
    
}
+ (BOOL)isCanPopNewPeopleRedPacket{
    NSDate *now = [NSDate date];
    NSString *agoKey = @"isCanPopNewPeopleRedPacket";
    NSString *agoDate = [[NSUserDefaults standardUserDefaults] objectForKey:agoKey];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowday = [formatter stringFromDate:now];
    if ([nowday isEqualToString:agoDate]) {
        return NO;
    }else{
        NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
        [dataUser setObject:nowday forKey:agoKey];
        [dataUser synchronize];
        return YES;
    }
}
@end
