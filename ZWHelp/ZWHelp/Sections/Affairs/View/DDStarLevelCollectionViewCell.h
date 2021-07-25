//
//  DDStarLevelCollectionViewCell.h
//  ZWHelp
//
//  Created by 杨旭 on 2021/1/30.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDStarLevelCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) NSIndexPath *indexPath;

@property (nonatomic ,strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
