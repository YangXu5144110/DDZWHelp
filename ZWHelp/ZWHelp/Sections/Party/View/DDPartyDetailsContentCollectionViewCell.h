//
//  DDPartyDetailsContentCollectionViewCell.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDPartyModel;
@interface DDPartyDetailsContentCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy)void(^clickplayBtnBlock)(void);

@property (nonatomic ,strong) DDPartyModel *partyModel;

@end

NS_ASSUME_NONNULL_END
