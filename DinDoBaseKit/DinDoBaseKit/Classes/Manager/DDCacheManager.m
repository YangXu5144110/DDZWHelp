//
//  DDCacheManager.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/7/2.
//  Copyright © 2020 杨旭. All rights reserved.
//

// 数据库名称
#define kDataBaseName @"zwb.sqlite"
#import "DDCacheManager.h"

@interface DDCacheManager ()

@end

@implementation DDCacheManager

+ (DDCacheManager *)shareManager{
    static DDCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DDCacheManager alloc] init];
    });
    return manager;
}

// 懒加载数据库
- (FMDatabase *)database {
    if (!_database) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:kDataBaseName];
        // 得到数据库
        self.database = [FMDatabase databaseWithPath:filePath];
    }
    return _database;
}

#pragma mark -  创建表
- (void)createTableWithType:(CacheDataType)type {
    
    // 创建表
    if ([self.database open]) {
        
        if (type == CacheDataTypeAffairs) {
            NSString *sql = [NSString stringWithFormat:@"create table if not exists affairsTab(affairs_id integer primary key autoincrement,userId text,token text,data text)"];
            BOOL rusult  = [self.database executeUpdate:sql];
            if (rusult == YES) {
                NSLog(@"创建成功");
            }else{
                NSLog(@"创建失败");
            }
        }
            // 关闭数据库
        [self.database close];
    }
}

#pragma mark -  保存数据
-(void)saveWithType:(CacheDataType)type dataStr:(NSString *)dataStr  {
   

    [self deteleWithType:type];

    
    // 判断用户信息是否为空
    NSString *userId = [DDUserInfoManager getUserInfo].userId;
    NSString *token = [DDUserInfoManager getUserInfo].token;
    if (userId.length == 0 || token.length == 0 || dataStr.length == 0 ) {
        return;
    }
    
    if (type == CacheDataTypeAffairs) {
        // 打开数据库
        if ([self.database open]) {
            // 添加操作
           BOOL rusult =  [self.database executeUpdateWithFormat:@"insert into affairsTab(userId,token,data)values(%@,%@,%@)",userId ,token, dataStr];
            if (rusult == YES) {
                NSLog(@"添加成功");
            }else{
                NSLog(@"添加失败");
            }
            
            // 关闭数据库
            [self.database close];
        }
    }
   
}

#pragma mark -  删除表
- (void)deteleWithType:(CacheDataType)type {
        // 1.打开数据库
    if ([self.database open]) {
     
        if (type == CacheDataTypeAffairs) {
            
            // 2.删除数据库操作
            BOOL rusult  =  [self.database executeUpdateWithFormat:@"delete from affairsTab"];
            if (rusult == YES) {
                NSLog(@"删除成功");
            }else{
                NSLog(@"删除失败");
            }
            // 3.关闭数据库
            [self.database close];
        }
         
    }
}

#pragma mark -  查询表中的数据
- (NSArray *)getDataWithType:(CacheDataType)type  {
    
//    // 初始化数据库信息
//    if (self.database == nil) {
//        [[DDCacheManager shareManager] database];
//        [[DDCacheManager shareManager] createTableWithType:CacheDataTypeAffairs];
//    }

    NSMutableArray * array = [NSMutableArray array];
    
    // 判断数据库与用户信息是否为空
    NSString *userId = [DDUserInfoManager getUserInfo].userId;
    NSString *token = [DDUserInfoManager getUserInfo].token;
    if (self.database == nil || userId.length == 0 || token.length == 0) {
        return array;
    }
    
    if (type == CacheDataTypeAffairs) {
         // 1.打开数据库
        if ([self.database open]) {
                // 2.查询操作
            FMResultSet *result = [self.database executeQuery:@"select * from affairsTab"];
            while ([result next]) {
                
                // 判断如果数据库保存的用户id是否是当前登录的用户id,不是重新请求新的数据
                NSString *userIds = [result stringForColumn:@"userId"];
                if ([userIds isEqualToString:userId]) {
                    NSString *dataStr = [result stringForColumn:@"data"];
                    NSArray *dataArr = [dataStr mj_JSONObject];
                    [array addObjectsFromArray:dataArr];
                }else {
                    return array;
                }
         
            }
                // 3.关闭数据库
            [self.database close];
        }
    }
   
    return array;
}

- (BOOL)isExistWithType:(CacheDataType)type dataStr:(NSString *)dataStr
{
    BOOL isExist = NO;
    
    if (type == CacheDataTypeAffairs) {
        if ([self.database open]) {
            FMResultSet *resultSet= [self.database executeQuery:@"select * from affairsTab where data = ?",dataStr];
            while ([resultSet next]) {
                if([resultSet stringForColumn:@"data"]) {
                    isExist = YES;
                }else{
                    isExist = NO;
                }
            }
        }
        [self.database close];
        
    }
    
    return isExist;
}


#pragma mark -  清除数据库文件
- (void)removeDataFile {
    
    if (isEnableCache == YES) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:kDataBaseName];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSError * error;
        [fm removeItemAtPath:filePath error:&error];
    }
    
}

@end
