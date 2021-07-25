//
//  DDWebManager.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>
//#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
NS_ASSUME_NONNULL_BEGIN
@interface DDWebManager : NSObject

+ (DDWebManager *)sharedWebManager;


/**
获取webUrl

@param link 链接
@param param 参数
*/
- (NSString *)getLinkUrlStringWithLink:(NSString *)link Param:(NSDictionary *)param;


/**
单次定位回调获取当前定位地址

@param success 定位成功
*/
- (void)userLocationSuccess:(void(^)(NSString *address))success;

/* 清理缓存**/
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
