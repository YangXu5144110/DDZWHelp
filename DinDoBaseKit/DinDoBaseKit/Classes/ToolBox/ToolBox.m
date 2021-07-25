//
//  ToolBox.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ToolBox.h"

@implementation ToolBox

+ (DDPromptUtils *)ddPromptUtils
{
    return [DDPromptUtils sharedDDPromptUtils];
}

+ (DDImageUtils *)ddImageUtils
{
    return [DDImageUtils sharedDDImageUtils];
}

+ (DDDeviceUtils *)ddDeviceUtils
{
    return [DDDeviceUtils sharedDDDeviceUtils];
}

+ (DDDateUtils *)ddDateUtils
{
    return [DDDateUtils sharedDDDateUtils];
}

+ (DDDataUtils *)ddDataUtils
{
    return [DDDataUtils sharedDDDataUtils];
}




@end
