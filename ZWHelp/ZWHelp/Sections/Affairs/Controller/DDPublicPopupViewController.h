//
//  DDPublicPopupViewController.h
//  ZWHelp
//
//  Created by 杨旭 on 2021/2/1.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPublicPopupViewController : DDBaseViewController

@property (nonatomic ,assign) NSInteger type;

@property (nonatomic ,strong) NSArray *listArr;

@property (nonatomic ,copy)void(^clickSelectIndex)(NSIndexPath *index);


@end

@interface DDPopupTableViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *selectBtn;

@end


NS_ASSUME_NONNULL_END
