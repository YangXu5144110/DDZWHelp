//
//  DDBaseViewController.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDBaseViewController ()

@end

@implementation DDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    if (@available(iOS 11.0,*)) {
        //Use UIScrollView's contentInsetAdjustmentBehavior instead
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configurateNavigationBarSetting];
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationPortrait);
//
//}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //设置只允许视频播放界面可以旋转，其他只能竖屏
    if ([self isKindOfClass:NSClassFromString(@"DDPartyTypeListViewController")]||
        [self isKindOfClass:NSClassFromString(@"DDPartyListViewController")]||
        [self isKindOfClass:NSClassFromString(@"DDPartyLearnViewController")]) {
        return UIInterfaceOrientationMaskAll;
    }else if ([self isKindOfClass:NSClassFromString(@"DDWebViewController")]){
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}
- (BOOL)shouldAutorotate
{
    if ([self isKindOfClass:NSClassFromString(@"DDPartyTypeListViewController")]||
        [self isKindOfClass:NSClassFromString(@"DDPartyListViewController")]||
        [self isKindOfClass:NSClassFromString(@"DDPartyLearnViewController")]||
        [self isKindOfClass:NSClassFromString(@"DDWebViewController")]) {
        return NO;
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back_black"] style:(UIBarButtonItemStyleDone) target:target action:action];
}

- (UIBarButtonItem *)customBackItemWithTitle:(NSString *)title Image:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:color_TextOne forState:(UIControlStateNormal)];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self
               action:@selector(back)
     forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configurateNavigationBarSetting {
    // 可滑动返回
    self.rt_disableInteractivePop = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
