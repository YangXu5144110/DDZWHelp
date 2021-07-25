//
//  UIViewController+RotationControl.h
//  AAChartKit
//
//  Created by 杨旭 on 2021/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RotationControl)

- (BOOL)shouldAutorotate;
@end

@interface UITabBarController (RotationControl)
- (BOOL)shouldAutorotate;

@end


@interface UINavigationController (RotationControl)
- (BOOL)shouldAutorotate;

@end

NS_ASSUME_NONNULL_END
