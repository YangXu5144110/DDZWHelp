//
//  DDPickerView.h
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PickerViewOneDelegate <NSObject>

@optional
- (void)PickerViewOneDelegateOncleck:(NSIndexPath*)indePath;


@end
@interface DDPickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame midArry:(NSMutableArray *)midArry;

@property (nonatomic, assign) id<PickerViewOneDelegate>delegate;

-(void)show;
-(void)close;



@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *rightBtnTitle;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
