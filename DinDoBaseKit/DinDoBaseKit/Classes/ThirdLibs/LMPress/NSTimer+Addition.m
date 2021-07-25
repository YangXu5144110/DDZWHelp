//
//  NSTimer+Addition.m
//  ZanXiaoQu
//
//  Created by user on 2018/1/24.
//  Copyright © 2018年 DianDu. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}  
@end
