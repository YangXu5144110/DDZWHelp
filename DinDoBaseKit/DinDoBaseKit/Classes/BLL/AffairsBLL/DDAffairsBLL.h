//
//  DDAffairsBLL.h
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/22.
//

#import "BaseBLL.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDAffairsBLL : BaseBLL

+ (DDAffairsBLL *)sharedAffairsBLL;

// 查询政务列表
typedef void (^onModuleSuccess)(NSArray *listArr);

// 查询星级评定列表
typedef void (^onStarListSuccess)(NSDictionary *dic);


/**
查询政务列表

@param onModuleSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryGetModuleOnModuleSuccess:(onModuleSuccess)onModuleSuccess
                            bllFailed:(bllFailed)bllFailed
                        onNetWorkFail:(onNetWorkFail)onNetWorkFail
                     onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
数据列表和数据统计接口

@param period 周期
@param gradeId 星级id
@param onStarListSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryStarListDataWithPeriod:(NSString *)period
                            gradeId:(NSString *)gradeId
                  onStarListSuccess:(onStarListSuccess)onStarListSuccess
                          bllFailed:(bllFailed)bllFailed
                      onNetWorkFail:(onNetWorkFail)onNetWorkFail
                   onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
周期下拉接口

@param onStarListSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryGetSelectDatSuccess:(onStarListSuccess)onStarListSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

@end

NS_ASSUME_NONNULL_END
