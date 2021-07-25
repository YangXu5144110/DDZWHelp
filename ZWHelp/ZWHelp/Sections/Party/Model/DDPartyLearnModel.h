//
//  DDPartyLearnModel.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/18.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPartyLearnModel : DDBaseModel

@property (nonatomic ,copy) NSString *ID;
@property (nonatomic ,copy) NSString *dtState;
@property (nonatomic ,copy) NSString *dorName;
@property (nonatomic ,copy) NSString *introduction;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *quName;
@property (nonatomic ,copy) NSString *releaseDate;
@property (nonatomic ,copy) NSString *textPart;


@end

NS_ASSUME_NONNULL_END
