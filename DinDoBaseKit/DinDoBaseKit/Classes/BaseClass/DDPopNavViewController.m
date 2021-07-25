//
//  DDPopNavViewController.m
//  DDWGB
//
//  Created by DinDo on 2020/8/31.
//  Copyright © 2020 DinDo. All rights reserved.
//

#import "DDPopNavViewController.h"

@interface DDPopNavViewController ()

@end

@implementation DDPopNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentSizeInPop = CGSizeMake(SCREEN_WIDTH, 350);
    self.contentSizeInPopWhenLandscape = CGSizeMake(SCREEN_WIDTH, 350);
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
