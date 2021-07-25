//
//  WGPublicBottomView.m
//  DDLife
//
//  Created by wanggang on 2019/7/23.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "WGPublicBottomView.h"

@interface WGPublicBottomView ()

@property (nonatomic ,strong) UIButton *applyBtn;

@end

@implementation WGPublicBottomView

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    [_applyBtn setBackgroundColor:backColor];
    
}

- (void)setTitle:(id)title{
    _title = title;
    [self setup];
}

- (void)setFont:(CGFloat)font {
    _font = font;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setup {
    for (UIView *vi in self.subviews) {
        [vi removeFromSuperview];
    }
    NSArray *arr;
    if ([_title isKindOfClass:[NSString class]]) {
        arr = @[_title];
    }else if ([_title isKindOfClass:[NSArray class]]){
        arr = _title;
    }
    NSMutableArray *tem = [NSMutableArray new];
    for (int i = 0; i < arr.count; i ++) {
        NSString *str = arr[i];
        UIButton *applyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        applyBtn.backgroundColor = APPTintColor;
        applyBtn.layer.masksToBounds = YES;
        applyBtn.layer.cornerRadius = 3.5;
        applyBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [applyBtn setTitle:str forState:UIControlStateNormal];
        applyBtn.tag = i + 10;
        [applyBtn addTarget:self action:@selector(applyBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:applyBtn];
        
        [tem addObject:applyBtn];
        if (arr.count == 1) {
            [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).mas_offset(UIEdgeInsetsMake(8, 15, 8, 15));
            }];
        }

    }
    if (tem.count > 1) {
        [tem mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:15 tailSpacing:15];
        [tem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
}

- (void)applyBtnAction:(UIButton *)btn {
    if (self.clickButtonBlock) {
        self.clickButtonBlock(btn.tag - 10);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
