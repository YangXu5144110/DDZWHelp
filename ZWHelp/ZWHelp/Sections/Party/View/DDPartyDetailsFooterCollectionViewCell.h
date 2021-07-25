//
//  DDPartyDetailsFooterCollectionViewCell.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDPartyModel;
@interface DDPartyDetailsFooterCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) DDPartyModel *partyModel;
@property (nonatomic ,strong) UILabel *contentLab;

@end

NS_ASSUME_NONNULL_END
