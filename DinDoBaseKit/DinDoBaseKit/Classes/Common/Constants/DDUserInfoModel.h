//
//  DDUserInfoModel.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserInfoModel : DDBaseModel <NSCoding>

/**
 token
 */
@property (nonatomic,copy) NSString *token;
/**
 用户名
 */
@property (nonatomic,copy) NSString *userName;
/**
 用户id
 */
@property (nonatomic,copy) NSString *userId;
/**
 用户头像
 */
@property (nonatomic,copy) NSString *headImg;
/**
 昵称
 */
@property (nonatomic,copy) NSString *nickname;
/**
 性别
 */
@property (nonatomic,assign) NSInteger sex;
/**
 手机号
 */
@property (nonatomic,copy) NSString *mobile;
/**
 单位名称
 */
@property (nonatomic,copy) NSString *unit;
/**
 部门名称
 */
@property (nonatomic,copy) NSString *department;
/**
 职务
 */
@property (nonatomic,copy) NSString *duty;
/**
 物业合同编号
 */
@property (nonatomic,copy) NSString *contractNO;
/**
 系统版本
 */
@property (nonatomic,copy) NSString *ios;
/**
 code
 */
@property (nonatomic,copy) NSString *code;
/**
 用户系统类型
 */
@property (nonatomic,assign) NSInteger userSystemType;
/**
 用户含有的模块
 */
@property (nonatomic,copy) NSString *modules;

/**
 当前登录人菜单权限
*/
@property (nonatomic,strong) NSMutableArray *listModule;
/**
 当前登录人所在网格及其下属网格（第一个为当前网格，每个网格的数据为id:
 网格idname:网格名
*/
@property (nonatomic,strong) NSArray *grids;

@end


@interface DDHomeMenuModel : DDBaseModel <NSCoding>


@property (nonatomic,copy) NSString *msgNum;
@property (nonatomic,assign) NSInteger sort;
@property (nonatomic,copy) NSString *stateMobile;
/** 菜单模块名称*/
@property (nonatomic,copy) NSString *moduleName;
/** 菜单地址ur*/
@property (nonatomic,copy) NSString *moduleUrl;
/** 搜索标题*/
@property (nonatomic,copy) NSString *searchTitle;
/** 搜索url*/
@property (nonatomic,copy) NSString *searchUrl;
/** 菜单图片url*/
@property (nonatomic,copy) NSString *pictureUrl;
/** 类型*/
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) UIImage *moduleImg;

@end


@interface DDHomeGridsModel : DDBaseModel <NSCoding>

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
