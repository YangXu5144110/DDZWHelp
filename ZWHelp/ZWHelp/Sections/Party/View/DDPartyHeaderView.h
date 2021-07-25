//
//  DDPartyHeaderView.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/15.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDPartyHeaderView : UICollectionReusableView

@property (nonatomic ,copy)void(^clickMoreBtnBlock)(NSIndexPath *indexPath);

@property (strong, nonatomic) NSIndexPath *indexPath;

@property(strong, nonatomic) UILabel *titleLab;
@property(strong, nonatomic) UIButton *moreBtn;




@end

NS_ASSUME_NONNULL_END
