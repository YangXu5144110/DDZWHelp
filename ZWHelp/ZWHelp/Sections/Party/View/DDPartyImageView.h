//
//  DDPartyImageView.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDPartyModel;
@interface DDPartyImageView : UIView
@property (nonatomic ,strong) UIButton *playBtn;
@property (nonatomic ,strong) DDPartyModel *partyModel;

@end

NS_ASSUME_NONNULL_END
