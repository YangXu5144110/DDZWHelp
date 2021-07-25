//
//  DDPartyGraphicView.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,GraphicViewType) {
    GraphicStateNormal,     // 默认没有图片
    GraphicStateSingle,     // 单图
    GraphicStateMore        // 多图
};
@class DDPartyModel;
@interface DDPartyGraphicView : UIView

@property (nonatomic ,assign) GraphicViewType type;

@property (nonatomic ,strong) DDPartyModel *partyModel;

@end

NS_ASSUME_NONNULL_END
