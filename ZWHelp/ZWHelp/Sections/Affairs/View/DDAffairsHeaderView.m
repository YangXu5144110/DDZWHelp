//
//  DDAffairsHeaderView.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/23.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDAffairsHeaderView.h"

@implementation DDAffairsHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLab];
//        [self addSubview:self.bottomLineView];
//        [self addSubview:self.lineView];
        [self addLayout];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
        _titleLab.textAlignment  =   NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = APPTintColor;
    }
    return _lineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = color_LineColor;
    }
    return _bottomLineView;
}

- (void)addLayout {
    
    YXWeakSelf
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.mas_centerY);
//        make.left.equalTo(@15);
//        make.size.mas_equalTo(CGSizeMake(2, 15));
//    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.width.offset(100);
    }];
    
//    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.mas_left).offset(15);
//        make.bottom.right.equalTo(@0.0);
//        make.height.equalTo(@1);
//    }];
}

@end
