//
//  DDWebManager.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDWebManager.h"
#import <CoreLocation/CoreLocation.h>

@interface DDWebManager ()<CLLocationManagerDelegate,BMKLocationManagerDelegate,BMKLocationAuthDelegate>
@property (nonatomic, strong) BMKLocation *location;///定位
//@property (nonatomic, strong) BMKUserLocation *userLocation;///用户位置
@property (nonatomic, strong) BMKLocationManager *locationManager;
@end

@implementation DDWebManager

+ (DDWebManager *)sharedWebManager
{
    static DDWebManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (NSString *)getLinkUrlStringWithLink:(NSString *)link Param:(NSDictionary *)param {
    
    // 公共参数
    NSMutableDictionary *totalParm = [NSMutableDictionary new];
    [totalParm setValue:[DDUserInfoManager getUserInfo].token forKey:@"token"];
    [totalParm setValue:[DDUserInfoManager getUserInfo].userId forKey:@"userId"];
    [totalParm setValue:[DDUserInfoManager getUserInfo].userName forKey:@"userName"];
    [totalParm setValue:[DDUserInfoManager getUserInfo].mobile forKey:@"phone"];
    [totalParm setValue:kBaseUrl forKey:@"basePath"];
    [totalParm setValue:kBaseUrl forKey:@"baseurl"];
    [totalParm setValue:@"yes" forKey:@"isVersion"];
    [totalParm setValue:kAppType forKey:@"appType"];
    NSString*version=BunldVersion;//App版本号
    [totalParm setValue:version forKey:@"versionNum"];
    [totalParm addEntriesFromDictionary:param];

    NSString *paramStr = [self getSignStringFromDic:totalParm];
//    NSString *url = [NSString stringWithFormat:@"%@%@",link,paramStr];
    NSString *url;
    if ([link hasPrefix:@"http"]&&[link containsString:@"?"]&&![link hasSuffix:@"?"]) {
        url = [NSString stringWithFormat:@"%@&%@",link,paramStr];
    }else {
        url = [NSString stringWithFormat:@"%@%@",link,paramStr];
    }
    
    return url;
}


- (NSString *)getSignStringFromDic:(NSDictionary *)dic
{
    
    NSMutableString *URL = [NSMutableString string];
    //获取字典的所有keys
    NSArray * keys = [dic allKeys];
    NSArray *sortKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSString *string;
    //拼接字符串
    for (int j = 0; j < sortKeys.count; j ++){
        if (j == 0){
            //拼接时不加&
            string = [NSString stringWithFormat:@"%@=%@", sortKeys[j], dic[sortKeys[j]]];
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"&%@=%@", sortKeys[j], dic[sortKeys[j]]];
        }
        //拼接字符串
        [URL appendString:string];
        
    }
    
    return URL;
}


#pragma mark - 单次定位成功回调
- (void)userLocationSuccess:(void(^)(NSString *address))success
{
    
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BMK_APP_KEY authDelegate:self];
    
    // 初始化
    [self locationManager];
    
    YXWeakSelf
    [_locationManager requestLocationWithReGeocode:YES
                                  withNetworkState:YES
                                   completionBlock:^(BMKLocation * _Nullable location,
                                                     BMKLocationNetworkState state, NSError * _Nullable error) {
                                       if (error) {
                                           NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                                           if (error.code == 2) {
                                               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"无法定位到您所在的位置信息，请到手机系统的[设置]->[隐私]-[定位服务]中打开定位服务,并允许使用定位服务" preferredStyle:UIAlertControllerStyleAlert];
                                               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                               }];
                                               UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                   //打开设置页面，去设置定位
                                                   NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                   if ([[UIApplication sharedApplication] canOpenURL:url]){
                                                       [[UIApplication sharedApplication] openURL:url];
                                                   }
                                               }];
                                               [alertController addAction:cancelAction];
                                               [alertController addAction:sureAction];
                                               [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
                                           }
                                           
                                       }
                                        weakSelf.location = location;
                                       if (location) {//得到定位信息，添加annotation
                                          
                                           if (location.location) {
                                               NSLog(@"LOC = %@",location.location);
                                           }
                                           if (location.rgcData) {
                                               NSLog(@"rgc = %@",[location.rgcData description]);
                                           }
                                           [weakSelf.locationManager stopUpdatingLocation];
                                           
                                           if (location) {
                                               NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",location.rgcData.country,location.rgcData.province,location.rgcData.city,location.rgcData.district,location.rgcData.street];
                                               if (success) {
                                                   success(address);
                                               }
                                           }
//                                           NSLog(@"%f -- %f", weakSelf.userLocation.location.coordinate.latitude ,weakSelf.userLocation.location.coordinate.longitude);
                                        }
                                   }];
    
}

//- (BMKUserLocation *)userLocation {
//    if (!_userLocation) {
//        _userLocation = [[BMKUserLocation alloc] init];
//    }
//    return _userLocation;
//}

- (BMKLocationManager *)locationManager{
    if (!_locationManager) {
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //设置是否允许后台定位
        //    bmklocationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
        
    }
    return _locationManager;
}

#pragma mark -  申请开启定位权限
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager {
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
}


#pragma mark - 清理缓存
- (void)clearCache {
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        NSLog(@"WKWebView 清理缓存完成");
    }];

}


@end
