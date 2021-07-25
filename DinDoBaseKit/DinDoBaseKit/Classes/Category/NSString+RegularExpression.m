//
//  NSString+RegularExpression.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)

- (BOOL)match:(NSString *)pattern {
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isMatchNricNumber {
    
    
    return [self match:@"^[0-9]\\d{6}[A-Za-z]$"];
}

- (BOOL)isMatchOnlyNumber {
    
    
    return [self match:@"^[0-9]*$"];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile
{
    
    NSString *mobile = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
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


- (BOOL)isNameValid {
    BOOL isValid = NO;
    if (self.length > 0){
        for (NSInteger i=0; i<self.length; i++){
            
            unichar chr = [self characterAtIndex:i];
            if (chr < 0x80){
                //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = NO;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    return isValid;
}
- (BOOL)isURL{
    return [self match:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];

}
///获取文字大小
-(CGSize)getTextRectWithFont:(UIFont*)font textWidth:(CGFloat)textWidth{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary* dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = CGSizeMake(textWidth, 9999);
    
    CGRect rect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return rect.size;
}
@end

