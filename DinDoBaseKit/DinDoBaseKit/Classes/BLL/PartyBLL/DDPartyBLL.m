//
//  DDPartyBLL.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/25.
//

#import "DDPartyBLL.h"

@implementation DDPartyBLL

+ (DDPartyBLL *)sharedPartyBLL
{
    static DDPartyBLL *partyBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        partyBLL = [[self alloc] init];
    });
    
    return partyBLL;
}

- (void)queryNewsTypeListOnSuccess:(onNewsTypeListSuccess)success
                         bllFailed:(bllFailed)bllFailed
                     onNetWorkFail:(onNetWorkFail)onNetWorkFail
                  onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"dj/mobile/partyOpen/newsTypeList.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSArray *listArr = resultDic[@"data"];
            success(listArr);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}



- (void)queryIndexDataListWithSign:(NSString *)sign
                       isRecommend:(NSString *)isRecommend
                         newTypeId:(NSString *)newTypeId
                         pageIndex:(NSString *)pageIndex
                          pageSize:(NSString *)pageSize
                  onDatListSuccess:(onDatListSuccess)onDatListSuccess
                         bllFailed:(bllFailed)bllFailed
                     onNetWorkFail:(onNetWorkFail)onNetWorkFail
                  onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"dj/mobile/partyOpen/dataList.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:sign forKey:@"sign"];
    [params setValue:isRecommend forKey:@"isRecommend"];
    [params setValue:newTypeId forKey:@"newTypeId"];
    [params setValue:pageIndex forKey:@"pageIndex"];
    [params setValue:pageSize forKey:@"pageSize"];
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSArray *listArr = resultDic[@"data"];
            onDatListSuccess(listArr);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
}




- (void)queryTwoStudyDataListWithSign:(NSString *)sign
                            pageIndex:(NSString *)pageIndex
                             pageSize:(NSString *)pageSize
                    onDataListSuccess:(onDataListSuccess)onDataListSuccess
                            bllFailed:(bllFailed)bllFailed
                        onNetWorkFail:(onNetWorkFail)onNetWorkFail
                     onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"dj/twoStudy/app/dataList.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:sign forKey:@"sign"];
    [params setValue:pageIndex forKey:@"pageIndex"];
    [params setValue:pageSize forKey:@"pageSize"];
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            NSArray *listArr = resultDic[@"data"];
            onDataListSuccess(listArr);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
}

- (void)queryIsPartyOnIsPartySuccess:(onIsPartySuccess)onIsPartySuccess
                           bllFailed:(bllFailed)bllFailed
                       onNetWorkFail:(onNetWorkFail)onNetWorkFail
                    onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"dj/memberValid/queryIsParty.do"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:kBaseUrl forKey:@"basePath"];
    [self executeTaskWithDic:params version:1 signStr:@"" requestMethod:NETWORK_TYPE_POST apiUrl:urlStr onSuccess:^(NSDictionary * _Nonnull resultDic) {
        
        [self analyseResult:resultDic bllSuccess:^{
            onIsPartySuccess(resultDic);
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
