//
//  Interface.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//


#ifndef Interface_h
#define Interface_h

//------ 是否开启离线缓存 ------
#define isEnableCache NO

//------ 网络请求接口 ------
#ifdef DEBUG //处于开发阶段
#define DevepMent 2  //1为开发接口， 2为正式接口
#else //处于开发阶段
#define DevepMent 2  //0为正式接口，永远不要改
#endif


#if DevepMent == 1

#define kCRMUrl    @"http://hdzuul.dd2007.cn:81/"
#define kBaseUrl   @"http://zjkjkqzjj.cn/cmgtest/"

//#define kBaseUrl   @"http://pwstest.dd2007.cn/cmgtest/"

// 本地地址
//#define kBaseUrl   @"http://zz.4kb.cn/"

//#define kBaseUrl   @"http://zhaowenquan.4kb.cn/"


#elif DevepMent == 2

#define kCRMUrl    @"https://coszuul.dd2007.com/"

//#define kBaseUrl   @"http://zjkjkqzjj.cn/cmg/"

#define kBaseUrl   [[NSUserDefaults standardUserDefaults] objectForKey:@"baseUrl"]


#endif


#pragma mark - 微心愿菜单
#define DD_Party_Wish  @"dj/mobile/tinyWish/tinyWishList.do?"

#pragma mark - 双报到菜单
#define DD_Party_TwoReport  @"dj/mobile/twoReport/twoReportAdd.do?"

#pragma mark - 三会一课菜单
#define DD_Party_ThreeLessons  @"dj/mobile/threeLessons/index.do?"

#pragma mark - 党建图文
#define DD_Party_Graphic  @"dj/mobile/partyOpen/partyOpenPage.do?"

#pragma mark - 网格数量
#define DD_Home_Meshing  @"meshingMobile/Management/meshingPage.do?"

#pragma mark - 实有建筑/实有住宅/公共建筑
#define DD_Home_PublicBuilding  @"zyBuildingMobile/Management/publicBuildingPage.do?"

#pragma mark - 通讯录
#define DD_Contacts_PhoneBook @"1_6/mobile/phoneBook/toPhoneBook.do?"

#pragma mark - 上报记录
#define DD_Affairs_HandlingFeedback @"zzMobile/dispute/handlingFeedback.do?type=2"

#pragma mark - 消息
#define DD_Messege_All @"1_6/mobile/message/index.do?"

#pragma mark - 我是党员
#define DD_PartyRZ @"/dj/memberValid/PartyRZ.do?"

#pragma mark - 首页扫一扫
#define DD_PropertyManage @"app/propertyManagement/propertyInfo.do?"

#pragma mark - 首页扫一扫商家
#define DD_Merchant @"meshing_mobile/merchant/appMerchantPage.do?"

#pragma mark - 走访日志
#define DD_ZFRZ @"oa/mobile/interview/zfrz.do?"


#endif /* Interface_h */
