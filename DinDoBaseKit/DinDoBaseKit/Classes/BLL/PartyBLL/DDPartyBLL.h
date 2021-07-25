//
//  DDPartyBLL.h
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/25.
//

#import "BaseBLL.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPartyBLL : BaseBLL

+ (DDPartyBLL *)sharedPartyBLL;

// 查询新闻类型
typedef void (^onNewsTypeListSuccess)(NSArray *listArr);

// 党建推荐查询接口
typedef void (^onDatListSuccess)(NSArray *listArr);

// 两学一做查询接口
typedef void (^onDataListSuccess)(NSArray *listArr);

// 判断是否是党员接口
typedef void (^onIsPartySuccess)(id resultDic);

/**
查询新闻类型

@param success 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryNewsTypeListOnSuccess:(onNewsTypeListSuccess)success
                         bllFailed:(bllFailed)bllFailed
                     onNetWorkFail:(onNetWorkFail)onNetWorkFail
                  onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
党建推荐查询接口

@param sign 1:党务公开 2:新闻发布
@param isRecommend 是否推荐 1: 是
@param newTypeId 新闻类型id
@param onDatListSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryIndexDataListWithSign:(NSString *)sign
                       isRecommend:(NSString *)isRecommend
                         newTypeId:(NSString *)newTypeId
                         pageIndex:(NSString *)pageIndex
                          pageSize:(NSString *)pageSize
                  onDatListSuccess:(onDatListSuccess)onDatListSuccess
                         bllFailed:(bllFailed)bllFailed
                     onNetWorkFail:(onNetWorkFail)onNetWorkFail
                  onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

/**
党建推荐查询接口

@param sign 1:党章党规  2:系列讲话 3:做合格党员
@param pageIndex 分页数
@param pageSize 分页数量
@param onDataListSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryTwoStudyDataListWithSign:(NSString *)sign
                            pageIndex:(NSString *)pageIndex
                             pageSize:(NSString *)pageSize
                    onDataListSuccess:(onDataListSuccess)onDataListSuccess
                            bllFailed:(bllFailed)bllFailed
                        onNetWorkFail:(onNetWorkFail)onNetWorkFail
                     onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
判断是否是党员

@param onIsPartySuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryIsPartyOnIsPartySuccess:(onIsPartySuccess)onIsPartySuccess
                           bllFailed:(bllFailed)bllFailed
                       onNetWorkFail:(onNetWorkFail)onNetWorkFail
                    onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

@end

NS_ASSUME_NONNULL_END
