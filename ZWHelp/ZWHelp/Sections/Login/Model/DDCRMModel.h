//
//  DDCRMModel.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCRMModel : DDBaseModel

@property (nonatomic ,copy) NSString *role;
@property (nonatomic ,copy) NSString *companyName;
@property (nonatomic ,copy) NSString *numer;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,assign) NSInteger state;
@property (nonatomic ,copy) NSString *department;
@property (nonatomic ,copy) NSString *userId;
@property (nonatomic ,copy) NSString *url;
@property (nonatomic ,copy) NSString *logTime;


@end

NS_ASSUME_NONNULL_END
