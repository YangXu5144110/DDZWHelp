//
//  NSString+Additional.h
//  DDLife
//
//  Created by 赵越 on 2019/7/13.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Additional)


/**
 * 只能为中文
 */
+ (BOOL)onlyInputChineseCharacters:(NSString*)string;


/**
 * 隐藏手机号中间四位数字
 */
+ (NSString *)numberSuitScanf:(NSString*)number;

/**
 * 判断手机号码格式是否正确
 */
+ (BOOL)valiMobile:(NSString *)mobile;

/**
 url 转字典
 */
+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;


/**
 json字符串转字典
 */
+ (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString;

/**
 替换
 */
+ (NSString *)Replace :(NSString *)str :(NSString *)oldstr :(NSString *)newstr;


/**
 字典转签名str

 @param dic 参数
 @return 获取签名字符串
 */
+ (NSString *)getSignStringFromDic:(NSDictionary *)dic;


/**
 str转MD5Str

 @param str str
 @return md5str
 */
+ (NSString *)getMD5StringFromStr:(NSString *)str;

/**
 获取手机型号

 @return 手机型号
 */
+ (NSString*)deviceType;
/**
 * 验证字符串是否为空
 */
+(BOOL)isBlankString:(NSString *)aStr;
/**
 推送使用 字符串转 32bytes位 token
 
 @param string token字符串
 @return 返回32bytes
 */
+ (NSData *)dataFromHexString:(NSString *)string;

/**
 格式化金额
formatPriceString
 @param str 金额
 @return 格式化
 */
+ (NSString *)formatPriceString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
