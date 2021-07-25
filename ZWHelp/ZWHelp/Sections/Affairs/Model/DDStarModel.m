//
//  DDStarModel.m
//  ZWHelp
//
//  Created by 杨旭 on 2021/2/1.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDStarModel.h"

@implementation DDStarModel

@end

@implementation DDPeriodModel

@end

@implementation DDExtendModel

- (void)setGrade:(NSString *)grade {
    _grade = grade;
    if ([_grade isEqualToString:@"5"]) {
        _grade = @"五";
    }else if ([_grade isEqualToString:@"4"]) {
        _grade = @"四";
    }else if ([_grade isEqualToString:@"3"]) {
        _grade = @"三";
    }else if ([_grade isEqualToString:@"2"]) {
        _grade = @"二";
    }else if ([_grade isEqualToString:@"1"]) {
        _grade = @"一";
    }else {
        _grade = @"零";
    }
}

@end

@implementation DDStarGoodsModel

@end
