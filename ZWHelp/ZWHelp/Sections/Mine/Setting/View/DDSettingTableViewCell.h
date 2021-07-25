//
//  DDSettingTableViewCell.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDSettingModel;
@interface DDSettingTableViewCell : UITableViewCell

@property (nonatomic ,copy) void(^swtichOnOrOff)(BOOL status);

@property (nonatomic ,strong) NSIndexPath *indexPath;
/** 标题*/
@property (nonatomic ,strong) UILabel *titleLab;
/** 副标题*/
@property (nonatomic ,strong) UILabel *subTitleLab;
/** 右边切换按钮*/
@property (nonatomic ,strong) UISwitch *isSwitch;

@property (nonatomic ,strong) UILabel *rightLab;

@property (nonatomic ,strong) DDSettingModel *setModel;

@end

NS_ASSUME_NONNULL_END
