//
//  Color.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#ifndef Color_h
#define Color_h

//          ------ 颜色配置 -------

//16进制颜色
#define HEX_COLOR(hexString)  [UIColor colorWithHexString:hexString]

//RGB颜色转换
#define ColorRGB(x,y,z,h)   [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:h]


//TabBar未选中
#define TABBAR_TITLE_UNSELECT   ColorRGB(157,157,157,1)
//TabBar选中
#define TABBAR_TITLE_SELECT     HEX_COLOR(@"#FF100F")
//Navi title
#define NAVI_TITLE              HEX_COLOR(@"#333333")
// 定义副标题颜色
#define NAVI_TITLE_SUB          HEX_COLOR(@"#666666")
// 定义边框颜色
#define BorderColor             HEX_COLOR(@"#cccccc")
//Navi bgColor
#define NAVI_BG_COLOR           HEX_COLOR(@"#F8F8F8")

//app主题色
#define APPTintColor            HEX_COLOR(@"#FF100F")
//背景颜色
#define VIEW_BACKCOROL          HEX_COLOR(@"#FFFFFF")

//主题色
#define MAIN_THEME_COLOR        HEX_COLOR(@"#FF100F")
// 定义咖啡色
#define color_CoffeeColor       HEX_COLOR(@"#5F3100")
//我的主页分割线
#define MINE_LINE_COLOR         HEX_COLOR(@"#F4F4F4")

// 定义全局背景色
#define color_BgColor [UIColor colorWithHexString:@"#ffffff"]

// 定义部分页面背景色
#define color_BackColor [UIColor colorWithHexString:@"#f8f8f8"]

// 定义标题颜色
#define color_TextOne [UIColor colorWithHexString:@"#333333"]

// 定义副标题颜色
#define color_TextTwo [UIColor colorWithHexString:@"#666666"]

// 定义副标题颜色
#define color_TextThree [UIColor colorWithHexString:@"#999999"]

// 定义副标题颜色
#define color_TextFour [UIColor colorWithHexString:@"#eeeeee"]

// 定义边框颜色
#define color_BorderColor [UIColor colorWithHexString:@"#cccccc"]

// 定义分割线色值
#define color_LineColor [UIColor colorWithHexString:@"#F4F4F4"]

// 定义绿色颜色
#define color_GreenColor [UIColor colorWithHexString:@"#00be00"]

// 定义橘色
#define color_OrangeColor [UIColor colorWithHexString:@"#ff8a09"]

// 定义白色
#define color_WhiteColor [UIColor colorWithHexString:@"#ffffff"]

// 定义红色
#define color_RedColor [UIColor colorWithHexString:@"#FE3A3B"]


#define kNotificationImageUrl @"NotificationImageUrl" // 修改用户头像


#endif /* Color_h */
