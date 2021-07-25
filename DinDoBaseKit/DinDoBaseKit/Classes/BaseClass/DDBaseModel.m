//
//  BaseModel.m
//  DDLife
//
//  Created by 赵越 on 2019/8/5.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDBaseModel.h"

@implementation DDBaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end
