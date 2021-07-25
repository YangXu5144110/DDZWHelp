//
//  DDAffairsBLL.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/22.
//

#import "DDAffairsBLL.h"

@implementation DDAffairsBLL

+ (DDAffairsBLL *)sharedAffairsBLL
{
    
    static DDAffairsBLL *affairsBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        affairsBLL = [[self alloc] init];
    });
    
    return affairsBLL;
}

- (void)queryGetModuleOnModuleSuccess:(onModuleSuccess)onModuleSuccess
                            bllFailed:(bllFailed)bllFailed
                        onNetWorkFail:(onNetWorkFail)onNetWorkFail
                     onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_4/app/getModule.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSArray *listArr = resultDic[@"data"];
            onModuleSuccess(listArr);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}


- (void)queryStarListDataWithPeriod:(NSString *)period
                            gradeId:(NSString *)gradeId
                  onStarListSuccess:(onStarListSuccess)onStarListSuccess
                          bllFailed:(bllFailed)bllFailed
                      onNetWorkFail:(onNetWorkFail)onNetWorkFail
                   onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"jsld/mobile/starRating/queryListData.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:period forKey:@"period"];
    [params setValue:gradeId forKey:@"gradeId"];

    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSDictionary *dic = resultDic;
            onStarListSuccess(dic);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}


- (void)queryGetSelectDatSuccess:(onStarListSuccess)onStarListSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"jsld/mobile/starRating/getSelectData.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSDictionary *dic = resultDic[@"data"];
            onStarListSuccess(dic);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
    
}


@end
