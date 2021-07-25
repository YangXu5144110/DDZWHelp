//
//  DDDataUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDDataUtils.h"
#import "SDImageCache.h"

@implementation DDDataUtils

+ (DDDataUtils *)sharedDDDataUtils
{
    
    static DDDataUtils *ddDataUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddDataUtils = [[DDDataUtils alloc] init];
        
    });
    
    return ddDataUtils;
}


- (BOOL)isBlankString:(id)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
}



- (void)clearCache {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    [self clearCache:cachesDir];
}
// 1.计算单个文件大小
- (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//// 2.计算文件夹大小(要利用上面的1提供的方法)
//- (float)folderSizeAtPath:(NSString *)path {
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    float folderSize = 0.0;
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            folderSize += [self fileSizeAtPath:absolutePath];
//        }
//        // SDWebImage框架自身计算缓存的实现
//        folderSize+=[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0;
//        return folderSize;
//    }
//    return 0;
//}

// 3.清除缓存
- (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
