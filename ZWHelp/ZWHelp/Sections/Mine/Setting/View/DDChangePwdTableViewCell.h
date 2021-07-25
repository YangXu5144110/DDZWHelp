//
//  DDChangePwdTableViewCell.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDChangePwdTableViewCell : UITableViewCell

@property (nonatomic ,strong) NSIndexPath *indexPath;

@property (nonatomic ,copy) void(^editTextBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END
