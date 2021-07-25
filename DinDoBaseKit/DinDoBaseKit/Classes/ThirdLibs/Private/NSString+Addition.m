//
//  NSString+Addition
//  LimitTextInput
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSString+Addition.h"
#import "LTConstants.h"

LTLoadCategory(NSString_Addition)

@implementation NSString (validate)

#pragma mark - 合法性检查

- (BOOL)isFullEmail{
    
    NSString *email_regex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", email_regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail{
    
    NSString *email_regex = @"^([A-Z0-9a-z._%+-]*)|"
    "([A-Z0-9a-z._%+-]*@[A-Za-z0-9.-]*)|"
    "([A-Z0-9a-z._%+-]*@[A-Za-z0-9.-]*\\.{0,1}[A-Za-z.]{2,})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", email_regex];
    return [predicate evaluateWithObject:self];
}
- (BOOL)isIdCard{
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)isTelephoneFullNumber{
    
    //添加了兼容 0  +86 前缀方法
    NSString *phoneNumber = [[self class] handlePhoneNumber:self];
    
    NSString *phone_number_regex = @"^1[0-9]{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone_number_regex];
    return [predicate evaluateWithObject:phoneNumber];
}

- (BOOL)isTelephoneNumber{
    
    //添加了兼容 0  +86 前缀方法
    NSString *phoneNumber = [[self class] handlePhoneNumber:self];
    
    NSString *phone_number_regex = @"^(1{0,1})|(1[0-9]{0,10})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone_number_regex];
    return [predicate evaluateWithObject:phoneNumber];
}

//判断是否是电话号码
- (BOOL)isMobileNumber{
    
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349|7[0-9]{2})\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:self] == YES)
    //        || ([regextestcm evaluateWithObject:self] == YES)
    //        || ([regextestct evaluateWithObject:self] == YES)
    //        || ([regextestcu evaluateWithObject:self] == YES))
    //    {
    
    //        return YES;
    //    }
    //    else
    //    {
    
    //        return NO;
    //    }
    //
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1(3|4|5|7|8)\\d{9}$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  数字合法性检查
 *
 *  @return BOOL
 */
- (BOOL)isNumber;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  整数或者小数合法性检查 两位小数
 *
 *  @return BOOL
 */
- (BOOL)isNumberOrDecimals;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$"];
    
    return [predicate evaluateWithObject:self];
}

/**
 *  英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isEnglishCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([A-Z]|[a-z])*|([A-Z]|[a-z])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  数字或英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isNumberOrEnglishCharacter;{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([A-Z]|[a-z]|[0-9]|[`~!@#$%^&*()+=|{}':;',\\\\[\\\\].<>/?~！@#¥%……&*（）——+|{}【】‘；：”“'。，、？])$"];
//    return [predicate evaluateWithObject:self];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d*|(\\d|[A-Z]|[a-z])|([A-Z]|[a-z]|[0-9]|[`~!@#$%^&*()+=|{}':;',\\\\[\\\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“'。，、？])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  数字和英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isNumberAndEnglishCharacter;{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d*|(\\d|[A-Z]|[a-z])|([A-Z]|[a-z]|[0-9]|[`~!@#$%^&*()+=|{}':;',\\\\[\\\\].<>/?~！@#¥%……&*（）——+|{}【】‘；：”“'。，、？])*$"];
    return [predicate evaluateWithObject:self];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]*$"];
//    return [predicate evaluateWithObject:self];
}

/**
 *  中文字符组合的合法性（纯中文）
 *
 *  @return 合法性
 */
- (BOOL)isChineseCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中文字符组合的合法性（包含中文）
 *
 *  @return 合法性
 */
- (BOOL)containChineseCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中英混合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isChineseOrEnglishCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]|[A-Z]|[a-z])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中英数字混合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isChineseOrEnglishOrNumberCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]|[A-Z]|[a-z] | \\d)*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  字符串是否中心对称
 *
 *  @return 对称状态
 */
- (BOOL)isSymmetric;{
    
    for (NSInteger nIndex = 0; nIndex < ([self length] + 1)/2; nIndex++) {
        
        NSString *header = [self substringWithRange:NSMakeRange(nIndex, 1)];
        NSString *tailer = [self substringWithRange:NSMakeRange([self length] - 1 - nIndex, 1)];
        
        if (![header isEqualToString:tailer]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark  处理电话号码
//处理  0 +86 等前缀,系统将统一去掉这些前缀
+ (NSString*)handlePhoneNumber:(NSString*)phoneNumber{
    
    if ([phoneNumber hasPrefix:@"0"]) {
        
        return  [phoneNumber substringFromIndex:1];
    }
    else if([phoneNumber hasPrefix:@"86"]){
        
        return  [phoneNumber substringFromIndex:2];
    }
    else if([phoneNumber hasPrefix:@"+86"]){
        
        return  [phoneNumber substringFromIndex:3];
    }
    else{
        
        return phoneNumber;
    }
}
- (BOOL)isMobilePhone
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
- (BOOL)judgeIdentityStringValid{

    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2){
        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
            return YES;
        }else{
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
            return YES;
        }else{
            return NO;
        } 
    }
    return YES;
}

/**
 校验银行卡

 @return 银行卡状态
 */
- (BOOL)isBankCard{
//    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = self.length - 1; i >= 0; i--)
    {
        digit = [self characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
    
//    NSString * lastNum = [[self substringFromIndex:(self.length-1)]copy];//取出最后一位
//    
//    NSString * forwardNum = [[self substringToIndex:(self.length -1)]copy];//前15或18位
//    
//    
//    
//    NSMutableArray * forwardArr = [NSMutableArray new];
//    
//    for (int i=0; i<forwardNum.length; i++) {
//        
//        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i,1)];
//        
//        [forwardArr addObject:subStr];
//        
//    }
//    
//    
//    
//    NSMutableArray * forwardDescArr = [NSMutableArray new];
//    
//    for (NSInteger i =(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
//        
//        [forwardDescArr addObject:forwardArr[i]];
//        
//    }
//    
//    
//    
//    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
//    
//    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
//    
//    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
//    
//    
//    
//    for (int i=0; i< forwardDescArr.count; i++) {
//        
//        NSInteger num = [forwardDescArr[i]intValue];
//        
//        if (i%2) {//偶数位
//            
//            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
//            
//        }else{//奇数位
//            
//            if (num *2 < 9) {
//                
//                [arrOddNum addObject:[NSNumber numberWithInteger:num *2]];
//                
//            }else{
//                
//                NSInteger decadeNum = (num *2) / 10;
//                
//                NSInteger unitNum = (num *2) % 10;
//                
//                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
//                
//                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
//                
//            }
//            
//        }
//        
//    }
//    
//    
//    
//    __block  NSInteger sumOddNumTotal = 0;
//    
//    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj,NSUInteger idx, BOOL *stop) {
//        
//        sumOddNumTotal += [obj integerValue];
//        
//    }];
//    
//    
//    
//    __block NSInteger sumOddNum2Total = 0;
//    
//    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj,NSUInteger idx, BOOL *stop) {
//        
//        sumOddNum2Total += [obj integerValue];
//        
//    }];
//    
//    
//    
//    __block NSInteger sumEvenNumTotal =0 ;
//    
//    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj,NSUInteger idx, BOOL *stop) {
//        
//        sumEvenNumTotal += [obj integerValue];
//        
//    }];
//    
//    
//    
//    NSInteger lastNumber = [lastNum integerValue];
//    
//    
//    
//    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
//    
//    
//    
//    return (luhmTotal%10 ==0)?YES:NO;
    
}
@end

@implementation  NSString (Length)

- (NSInteger)englishStringLength{
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] ==0 ) {
        
        return 0;
    }else{
        
        const char  *cString = [self UTF8String];
        
        return strlen(cString);
    }
}

/**
 *  计算中英文混合的字符串的字节数
 *
 *   中英文混合的字符串
 *
 *  @return 字节数
 */
- (NSInteger)stringLength {
    
    NSInteger strlength = 0;
    
    //  这里一定要使用gbk的编码方式，网上有很多用Unicode的，但是混合的时候都不行
    
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    char* p = (char*)[self cStringUsingEncoding:gbkEncoding];
    
    for (NSInteger i=0 ; i<[self lengthOfBytesUsingEncoding:gbkEncoding] ;i++) {
        
        if (p) {
            
            p++;
            strlength++;
        }
        else {
            
            p++;
        }
    }
    return strlength;
}

/**
 *  中英文混合的字符串限制在字节数以内
 *
 *  @param  byteSize 字节数
 *
 *  @return 中英字符
 */
- (NSString*)substringInLimitByteSize:(NSInteger)byteSize;{
    
    NSString *subString = nil;
    NSInteger curLength = 0;
    
    for (NSInteger nIndex = 0; nIndex < [self length]; nIndex++) {
        
        NSString *etSubString = [self substringWithRange:NSMakeRange(nIndex, 1)];
        
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        curLength += [etSubString lengthOfBytesUsingEncoding:gbkEncoding];
        
        if (curLength > byteSize && nIndex) {
            
            break;
        }
        else{
            
            subString = [self substringToIndex:nIndex+1];
        }
    }
    return subString;
}

@end
