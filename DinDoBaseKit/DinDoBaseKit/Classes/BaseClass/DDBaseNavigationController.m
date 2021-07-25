//
//  DDBaseNavigationController.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDBaseNavigationController.h"

@interface DDBaseNavigationController ()

@end

@implementation DDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏分割线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count==1) {

        viewController.hidesBottomBarWhenPushed = YES;
    }
    viewController.editing = NO;
    [super pushViewController:viewController animated:animated];
}


- (void)returnViewController{
    [self popViewControllerAnimated:YES];
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
