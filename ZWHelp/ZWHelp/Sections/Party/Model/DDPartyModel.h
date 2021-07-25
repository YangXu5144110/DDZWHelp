//
//  DDPartyModel.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/25.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DDPartyEntityModel;
@interface DDPartyModel : DDBaseModel

@property (nonatomic ,strong) NSDictionary *entity;
@property (nonatomic ,strong) NSArray *attachmentList;
@property (nonatomic ,strong) DDPartyEntityModel *entityModel;
@end

@interface DDPartyEntityModel : DDBaseModel

@property (nonatomic ,copy) NSString *ID;
@property (nonatomic ,copy) NSString *sign;
//@property (nonatomic ,copy) NSString *newTypeId;
@property (nonatomic ,copy) NSString *updateTime;
@property (nonatomic ,copy) NSString *active;
@property (nonatomic ,copy) NSString *createPerson;
@property (nonatomic ,copy) NSString *organId;
@property (nonatomic ,copy) NSString *organization;

/// 发布类型 1：图文 2：纯图片 3：视频
@property (nonatomic ,assign) NSInteger relType1;
/// 发布标题
@property (nonatomic ,copy) NSString *relTitle;
/// 发布内容
@property (nonatomic ,copy) NSString *relContent;
/// 发布时间
@property (nonatomic ,copy) NSString *relDateTime;
@property (nonatomic ,copy) NSString *isRecommend;
@property (nonatomic ,copy) NSString *createTime;
@property (nonatomic ,copy) NSString *remark;
@property (nonatomic ,copy) NSString *relUserId;
@property (nonatomic ,copy) NSString *updatePerson;
@property (nonatomic ,copy) NSString *isRel;
@property (nonatomic ,copy) NSString *relWay;

@property (nonatomic ,assign) CGFloat titleHeight;
@property (nonatomic ,assign) CGFloat cellHeight;


@end

@interface DDPartyListModel : DDBaseModel

@property (nonatomic ,copy) NSString *ID;
@property (nonatomic ,copy) NSString *sign;
@property (nonatomic ,copy) NSString *fileName;
@property (nonatomic ,copy) NSString *fileSuffix;
@property (nonatomic ,copy) NSString *fileSize;
@property (nonatomic ,copy) NSString *filePath;
@property (nonatomic ,copy) NSString *remark;

@end


@interface DDPartyTypeModel : DDBaseModel

@property (nonatomic ,copy) NSString *ID;
@property (nonatomic ,copy) NSString *state;
@property (nonatomic ,copy) NSString *createPerson;
@property (nonatomic ,copy) NSString *isDefault;
@property (nonatomic ,assign) NSInteger code;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *sign;
@property (nonatomic ,assign) NSInteger sort;
@property (nonatomic ,copy) NSString *createTime;
@property (nonatomic ,copy) NSString *updateTime;


@end
NS_ASSUME_NONNULL_END
