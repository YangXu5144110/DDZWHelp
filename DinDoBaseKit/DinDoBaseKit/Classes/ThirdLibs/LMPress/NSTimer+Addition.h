//
//  NSTimer+Addition.h
//  ZanXiaoQu
//
//  Created by user on 2018/1/24.
//  Copyright © 2018年 DianDu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;  
@end
