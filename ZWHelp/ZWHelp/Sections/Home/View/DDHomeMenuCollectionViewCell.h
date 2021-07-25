//
//  DDHomeMenuCollectionViewCell.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDHomeMenuModel;
@interface DDHomeMenuCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) DDHomeMenuModel *menuModel;

@end

NS_ASSUME_NONNULL_END
