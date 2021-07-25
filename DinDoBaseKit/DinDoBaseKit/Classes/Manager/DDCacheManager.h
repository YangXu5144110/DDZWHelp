//
//  DDCacheManager.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/7/2.
//  Copyright © 2020 杨旭. All rights reserved.
//


#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CacheDataType) {
    CacheDataTypeAffairs,    // 政务
    CacheDataTypeParty,      // 党建
   
};

@interface DDCacheManager : NSObject

// 创建数据库
@property (nonatomic ,strong)FMDatabase *database;

// 单例
+ (DDCacheManager *)shareManager;

// 创建表
- (void)createTableWithType:(CacheDataType)type;

// 保存数据库信息
- (void)saveWithType:(CacheDataType)type dataStr:(NSString *)dataStr;

// 删除数据库表
- (void)deteleWithType:(CacheDataType)type;

// 查询表中的数据
- (NSArray *)getDataWithType:(CacheDataType)type;

// 查询表中的数据与网络请求新数据是否相同
- (BOOL)isExistWithType:(CacheDataType)type dataStr:(NSString *)dataStr;

// 清除数据库文件
- (void)removeDataFile;

@end

NS_ASSUME_NONNULL_END
