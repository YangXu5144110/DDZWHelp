//
//  NSArray+LogChinese.m
//  EffectiveDemo
//
//  Created by TomLong on 2019/8/16.
//  Copyright © 2019年 ZLJ. All rights reserved.
//

#import "NSArray+LogChinese.h"

@implementation NSArray (LogChinese)
- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    return str;
}
@end
