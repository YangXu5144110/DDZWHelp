//
//  DDStarModel.h
//  ZWHelp
//
//  Created by 杨旭 on 2021/2/1.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDStarModel : DDBaseModel

// 星级id
@property (nonatomic,copy) NSString  *Id;
// 星级
@property (nonatomic,copy) NSString  *grade;
@property (nonatomic,assign) BOOL  selected;
@end

@interface DDPeriodModel : DDBaseModel

// 周期
@property (nonatomic,copy) NSString  *period;
@property (nonatomic,assign) BOOL  selected;

@end

@interface DDExtendModel : DDBaseModel

// 数量
@property (nonatomic,assign) NSInteger  num;
// 星级
@property (nonatomic,strong) NSString  *grade;


@end

@interface DDStarGoodsModel : DDBaseModel

// id
@property (nonatomic,copy) NSString  *Id;
// 商家id
@property (nonatomic,copy) NSString  *merchantId;
// 商家名称
@property (nonatomic,copy) NSString  *merchantName;
// 评分
@property (nonatomic,assign) NSInteger  score;
// 星级
@property (nonatomic,assign) NSInteger  grade;
// 图片
@property (nonatomic,copy) NSString  *filePath;
@end


NS_ASSUME_NONNULL_END
