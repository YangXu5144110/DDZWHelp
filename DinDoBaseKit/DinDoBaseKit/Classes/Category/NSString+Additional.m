//
//  NSString+Additional.m
//  DDLife
//
//  Created by 赵越 on 2019/7/13.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NSString+Additional.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>


@implementation NSString (Additional)



+ (BOOL)onlyInputChineseCharacters:(NSString*)string{
    NSString *zhString = @"[\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zhString];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}

+ (NSString *)numberSuitScanf:(NSString*)number {
    //首先验证是不是手机号码
    NSString *pattern = @"^1+[3-9]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isOk = [pred evaluateWithObject:number];
    if (isOk) {//如果是手机号码的话
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }
    return number;
    
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length == 11){
        NSString *str1 = [mobile substringToIndex:1];
        if ([str1 isEqualToString:@"1"]) {
            return YES;
        }
        return NO;
    }else{
        return NO;
    }
}


/**
 url 转字典
 */
+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


/**
 json字符串转字典
 */
+ (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString {
    
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
    
}

/**
 替换
 */
+(NSString *)Replace:(NSString *)str :(NSString *)oldstr :(NSString *)newstr
{
    if([str isEqual:nil] || [oldstr isEqual:nil] || [newstr isEqual:nil])
    {
        return  @"";
    }
    return [str stringByReplacingOccurrencesOfString:oldstr withString:newstr];
}


+ (NSString *)getSignStringFromDic:(NSDictionary *)dic
{
    
    NSMutableString *URL = [NSMutableString string];
    //获取字典的所有keys
    NSArray * keys = [dic allKeys];
    NSArray *sortKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSString *string;
    //拼接字符串
    for (int j = 0; j < sortKeys.count; j ++){
        if (j == 0){
            //拼接时不加&
            string = [NSString stringWithFormat:@"%@=%@", sortKeys[j], dic[sortKeys[j]]];
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"&%@=%@", sortKeys[j], dic[sortKeys[j]]];
        }
        //拼接字符串
        [URL appendString:string];
        
    }
    
    return URL;
}


+ (NSString *)getMD5StringFromStr:(NSString *)str
{
    
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    output = [output uppercaseString].copy;
    
    return output;
}
#pragma mark - 获取手机型号
+ (NSString*)deviceType
{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";//国行、日版、港行
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";//港行、国行
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";//美版、台版
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";//美版、台版
    
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";//国行(A1863)、日行(A1906)
    
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";//美版(Global/A1905)
    
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";//国行(A1864)、日行(A1898)
    
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";//美版(Global/A1897)
    
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";//国行(A1865)、日行(A1902)
    
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";//美版(Global/A1901)
    
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}
+(BOOL)isBlankString:(NSString *)aStr {
    
    if(!aStr){
        return YES;
    }
    
    if([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    
    if (!trimmedStr.length){
        return YES;
    }
    return NO;
    
}
/**
 字符串转 32bytes位 token
 */
+ (NSData *)dataFromHexString:(NSString *)string {
    
    if (string.length > 0) {
        NSMutableData*apnsTokenMutableData = [[NSMutableData alloc]init];
        
        unsigned char whole_byte;
        
        char byte_chars[3] = {'\0','\0','\0'};
        
        int i;
        
        for(i=0; i < [string length]/2; i++) {
            
            byte_chars[0] = [string characterAtIndex:i*2];
            
            byte_chars[1] = [string characterAtIndex:i*2+1];
            
            whole_byte =strtol(byte_chars,NULL,16);
            
            [apnsTokenMutableData appendBytes:&whole_byte length:1];
            
        }
        
        NSData*apnsTokenData = [NSData dataWithData:apnsTokenMutableData];
        
        return  apnsTokenData;
    }
    return nil;
}
+ (NSString *)formatPriceString:(NSString *)string{
    NSMutableString *fomatString = [[NSMutableString alloc]initWithString:@"###,##0.00"];
    
    NSDecimalNumberHandler *hander = [[NSDecimalNumberHandler alloc]initWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *decimal = [[NSDecimalNumber alloc]initWithString:string?:@"0"];
    decimal = [decimal decimalNumberByRoundingAccordingToBehavior:hander];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterNoStyle;
    [formatter setPositiveFormat:fomatString];
    return [formatter stringFromNumber:decimal];
    
}




@end
