//
//  DDUserInfoModel.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDUserInfoModel.h"
#import <objc/runtime.h>

@implementation DDUserInfoModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"listModule" : [DDHomeMenuModel class],
             @"grids":[DDHomeGridsModel class]};
}

- (void)setListModule:(NSMutableArray *)listModule {
    _listModule = listModule;
    
    DDHomeMenuModel *menuModel = [DDHomeMenuModel new];
    [menuModel setModuleName:@"全部"];
    [menuModel setModuleImg:[UIImage imageNamed:@"home_all"]];
    [_listModule addObject:menuModel];
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([DDUserInfoModel class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([DDUserInfoModel class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            if (value) {
                [self setValue:value forKey:key];
            }
        }
        free(ivars);
    }
    return self;
    
}




@end


@implementation DDHomeMenuModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([DDHomeMenuModel class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([DDHomeMenuModel class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            if (value) {
                [self setValue:value forKey:key];
            }
        }
        free(ivars);
    }
    return self;
    
}



@end


@implementation DDHomeGridsModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([DDHomeGridsModel class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([DDHomeGridsModel class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            if (value) {
                [self setValue:value forKey:key];
            }
        }
        free(ivars);
    }
    return self;
    
}



@end
