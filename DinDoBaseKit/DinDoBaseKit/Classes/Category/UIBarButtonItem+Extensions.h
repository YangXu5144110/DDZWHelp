//
//  UIBarButtonItem+Extensions.h
//  AFNetworking
//
//  Created by 杨旭 on 2020/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extensions)

/**
设置导航栏左边的item

@param title 标题
@param imageStr  图片名称
@return 返回的item
*/
+ (UIBarButtonItem *)initLeftItems:(NSString *)title imageStr:(NSString *)imageStr target:(id)target action:(SEL)action;


@end

NS_ASSUME_NONNULL_END
