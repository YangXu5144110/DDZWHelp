//
//  DDHomeNumberCollectionViewCell.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDHomeNumModel;
@interface DDHomeNumberCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) NSIndexPath *indexPath;

@property (nonatomic ,strong) DDHomeNumModel *numModel;

@end

NS_ASSUME_NONNULL_END
