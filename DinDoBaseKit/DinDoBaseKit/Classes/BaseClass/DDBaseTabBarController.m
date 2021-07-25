//
//  DDBaseTabBarController.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDBaseTabBarController.h"

#import "DDBaseNavigationController.h"
#import "DDBaseViewController.h"

@interface DDBaseTabBarController ()
@property (nonatomic,strong) DDBaseNavigationController *partyNavi;//党建
@property (nonatomic,strong) DDBaseNavigationController *affairsNavi;//政务
@property (nonatomic,strong) DDBaseNavigationController *homeNavi;//首页
@property (nonatomic,strong) DDBaseNavigationController *contactsNavi;//通讯录
@property (nonatomic,strong) DDBaseNavigationController *meNavi;//我的

@property (nonatomic,strong)  NSMutableDictionary *attrs;//未选中字体设置
@property (nonatomic,strong) NSMutableDictionary *selectedAttrs;//选中字体设置
@end

@implementation DDBaseTabBarController

- (void)loginReloadViewController:(NSArray <UIViewController *>*)rVC{
    
    NSArray *childArray = @[self.partyNavi,
                            self.affairsNavi,
                            self.homeNavi,
                            self.contactsNavi,
                            self.meNavi];
   self.viewControllers = childArray;
    self.selectedIndex = 0;

}
- (instancetype)init {
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]]) {
        [self customizeTabBarAppearance];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setTranslucent:NO];

    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    [self hideTabBarShadowImageView];
    
//        [self addChildViewController];
    
}


- (NSArray *)viewControllersForTabBar {
    
    Class partyClass = NSClassFromString(@"DDPartyTypeListViewController");
    DDBaseViewController *firstViewController = [[partyClass alloc] init];
    _partyNavi = [[DDBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [_partyNavi cyl_setHideNavigationBarSeparator:YES];
    [_partyNavi cyl_setNavigationBarHidden:YES];
    
    Class affairsClass = NSClassFromString(@"DDAffairsViewController");
    DDBaseViewController *secondViewController = [[affairsClass alloc] init];
    _affairsNavi = [[DDBaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [_affairsNavi cyl_setHideNavigationBarSeparator:YES];
    [_affairsNavi cyl_setNavigationBarHidden:YES];
    
    Class homeClass = NSClassFromString(@"DDHomeViewController");
    DDBaseViewController *thirdViewController = [[homeClass alloc] init];
    _homeNavi = [[DDBaseNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    [_homeNavi cyl_setHideNavigationBarSeparator:YES];
    [_homeNavi cyl_setNavigationBarHidden:YES];

    
    Class contactsClass = NSClassFromString(@"DDWebViewController");
    DDBaseViewController *fourthViewController = [[contactsClass alloc] init];
    _contactsNavi = [[DDBaseNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    [_contactsNavi cyl_setHideNavigationBarSeparator:YES];
    [_contactsNavi cyl_setNavigationBarHidden:YES];

    Class mineClass = NSClassFromString(@"DDMineViewController");
    DDBaseViewController *fiveViewController = [[mineClass alloc] init];
    _meNavi = [[DDBaseNavigationController alloc]
                                                    initWithRootViewController:fiveViewController];
    [_meNavi cyl_setHideNavigationBarSeparator:YES];
    [_meNavi cyl_setNavigationBarHidden:YES];

    NSArray *viewControllers = @[
                                _partyNavi,
                                _affairsNavi,
                                _homeNavi,
                                _contactsNavi,
                                _meNavi
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"党建",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tab_party_unselect"],  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"tab_party_select",  /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"政务",
                                                  CYLTabBarItemImage : [UIImage imageNamed:@"tab_affairs_unselect"],
                                                  CYLTabBarItemSelectedImage : @"tab_affairs_select",
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tab_home_unselect"],
                                                 CYLTabBarItemSelectedImage : @"tab_home_select",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes =@{
                                                 CYLTabBarItemTitle : @"通讯录",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tab_contacts_unselect"],
                                                 CYLTabBarItemSelectedImage : @"tab_contacts_select",
                                                 };
    NSDictionary *fiveTabBarItemsAttributes =@{
                                                    CYLTabBarItemTitle : @"我的",
                                                    CYLTabBarItemImage : [UIImage imageNamed:@"tab_me_unselect"],
                                                    CYLTabBarItemSelectedImage : @"tab_me_select",
                                                    };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fiveTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    [self rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 设置文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];
    // 设置文字的前景色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//    [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set background color
    // 设置 TabBar 背景
    // 半透明
    //    [UITabBar appearance].translucent = YES;
    // [UITabBar appearance].barTintColor = [UIColor cyl_systemBackgroundColor];
    // [[UITabBar appearance] setBackgroundColor:[UIColor cyl_systemBackgroundColor]];
    
    
    //     [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
    //    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor systemGrayColor]];
    
    //Three way to deal with shadow 三种阴影处理方式：
    // NO.3, without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    // NO.2，using Image
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"TabBar_Bg_Shadow"]];
    // NO.1，using layer to add shadow. note:recommended. 推荐该方式，可以给PlusButton突出的部分也添加上阴影
    //    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    //    tabBarController.tabBar.layer.shadowRadius = 15.0;
    //    tabBarController.tabBar.layer.shadowOpacity = 0.2;
    //    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    //    tabBarController.tabBar.layer.masksToBounds = NO;
    //    tabBarController.tabBar.clipsToBounds = NO;
}
@end
