//
//  DDAffairsModel.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/23.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDAffairsGroupModel.h"

@implementation DDAffairsGroupModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"childModule" : [DDAffairsModel class]};
}

@end

@implementation DDAffairsModel

@end
