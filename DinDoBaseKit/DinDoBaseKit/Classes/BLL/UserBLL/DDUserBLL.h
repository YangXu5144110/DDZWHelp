//
//  DDUserBLL.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "BaseBLL.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserBLL : BaseBLL

+ (DDUserBLL *)sharedUserBLL;

// 上传头像
typedef void (^onUploadHeadImgSuccess)(id responseObject);

// 修改性别成功
typedef void (^onUpdateSexSuccess)(void);

// 修改密码成功
typedef void (^onUpdatePwdSuccess)(void);

// 查询共享手机号设置成功
typedef void (^onShareSuccess)(id model);

// 共享手机号设置
typedef void (^onUpdateShareSuccess)(void);


/**
上传头像

@param image 图片
@param success 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)uploadHeadImgWithImage:(UIImage *)image
                       Success:(onUploadHeadImgSuccess)success
                     bllFailed:(bllFailed)bllFailed
                 onNetWorkFail:(onNetWorkFail)onNetWorkFail
              onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;



/**
修改姓名性别

@param sex 性别
@param onUpdateSexSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)updatePersonInfoWithSex:(NSString *)sex
             onUpdateSexSuccess:(onUpdateSexSuccess)onUpdateSexSuccess
                      bllFailed:(bllFailed)bllFailed
                  onNetWorkFail:(onNetWorkFail)onNetWorkFail
               onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
修改密码

@param oldPassword 原密码
@param newPassword 新密码
@param onUpdatePwdSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)updatePwdWithOldPassword:(NSString *)oldPassword
                     newPassword:(NSString *)newPassword
              onUpdatePwdSuccess:(onUpdatePwdSuccess)onUpdatePwdSuccess
                       bllFailed:(bllFailed)bllFailed
                   onNetWorkFail:(onNetWorkFail)onNetWorkFail
                onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

/**
查询共享手机号设置

@param userId 用户id
@param onUpdatePwdSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)queryShareWithUserId:(NSString *)userId
              OnShareSuccess:(onShareSuccess)onShareSuccess
                   bllFailed:(bllFailed)bllFailed
               onNetWorkFail:(onNetWorkFail)onNetWorkFail
            onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;


/**
共享手机号设置

@param userId 用户id
@param state  state (0为否   1为是)
@param onUpdatePwdSuccess 成功
@param bllFailed 失败
@param onNetWorkFail 网络错误
@param onRequestTimeOut 超时
*/
- (void)updateShareWithUserId:(NSString *)userId
                        State:(NSString *)state
        onUpdateShareSuccess:(onUpdateShareSuccess)onUpdateShareSuccess
                   bllFailed:(bllFailed)bllFailed
               onNetWorkFail:(onNetWorkFail)onNetWorkFail
            onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut;

@end

NS_ASSUME_NONNULL_END
