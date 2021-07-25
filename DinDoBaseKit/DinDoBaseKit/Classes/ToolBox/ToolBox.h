//
//  ToolBox.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDPromptUtils.h"
#import "DDImageUtils.h"
#import "DDDeviceUtils.h"
#import "DDDateUtils.h"
#import "DDDataUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolBox : NSObject


+ (DDPromptUtils *)ddPromptUtils;

+ (DDImageUtils *)ddImageUtils;

+ (DDDeviceUtils *)ddDeviceUtils;

+ (DDDateUtils *)ddDateUtils;

+ (DDDataUtils *)ddDataUtils;




@end

NS_ASSUME_NONNULL_END
