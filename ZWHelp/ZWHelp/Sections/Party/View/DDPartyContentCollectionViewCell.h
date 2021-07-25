//
//  DDPartyBannceCollectionViewCell.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/25.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDPartyModel;
@interface DDPartyContentCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy)void(^clickPlayBlock)(void);

@property (nonatomic ,strong) NSIndexPath *indexPath;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) DDPartyModel *partyModel;

@end

NS_ASSUME_NONNULL_END
