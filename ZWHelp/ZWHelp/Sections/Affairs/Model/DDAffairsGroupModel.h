//
//  DDAffairsModel.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/23.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDAffairsGroupModel : DDBaseModel


@property (nonatomic ,copy) NSString *ID;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSArray *childModule;

@end

@interface DDAffairsModel : DDBaseModel

@property (nonatomic ,copy) NSString *ID;
@property (nonatomic ,copy) NSString *msgNum;
@property (nonatomic ,copy) NSString *sort;
@property (nonatomic ,copy) NSString *stateMobile;
@property (nonatomic ,copy) NSString *parentId;
@property (nonatomic ,copy) NSString *moduleName;
@property (nonatomic ,copy) NSString *searchTitle;
@property (nonatomic ,copy) NSString *moduleUrl;
@property (nonatomic ,copy) NSString *searchUrl;
@property (nonatomic ,copy) NSString *pictureUrl;
@property (nonatomic ,copy) NSString *type;

@end
NS_ASSUME_NONNULL_END
