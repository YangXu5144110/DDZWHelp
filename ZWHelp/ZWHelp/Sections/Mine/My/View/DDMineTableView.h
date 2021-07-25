//
//  DDMineTableView.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/14.
//  Copyright © 2020 wg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDMineTableView : UITableView
@property (nonatomic ,copy)void(^clickSelectRowAtIndexPath)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
