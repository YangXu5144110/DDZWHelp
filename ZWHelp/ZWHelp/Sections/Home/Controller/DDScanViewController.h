//
//  DDScanViewController.h
//  DDLife
//
//  Created by wanggang on 2019/7/24.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import <LBXScanViewController.h>

NS_ASSUME_NONNULL_BEGIN
@interface DDScanViewController : LBXScanViewController

@property(nonatomic, strong) UIViewController *vc;

// type 0.获取url 1.获取扫描内容
@property (nonatomic ,assign) NSInteger type;

@property (nonatomic,copy) void(^scanSuccess)(UIViewController *vc);
@property (nonatomic,copy) void(^scanSuccessReslut)(NSString *reslut);


@end

NS_ASSUME_NONNULL_END
