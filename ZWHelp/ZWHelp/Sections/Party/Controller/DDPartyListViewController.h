//
//  DDPartyDetailsViewController.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/25.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDBaseViewController.h"
#import "JXCategoryListContainerView.h"

typedef NS_ENUM(NSInteger,PartyListViewType) {
    PartyListStateHome,     // 首页
    PartyListStateLearn,    // 两学一做
};

NS_ASSUME_NONNULL_BEGIN
@class DDPartyTypeModel;
@interface DDPartyListViewController : DDBaseViewController <JXCategoryListContentViewDelegate>

@property (nonatomic ,strong) DDPartyTypeModel *typeModel;

@property (nonatomic ,assign) PartyListViewType type;

@property (nonatomic ,strong) NSString *sign;

@end

NS_ASSUME_NONNULL_END
