//
//  DDPartyHeaderView.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/15.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyHeaderView.h"

@implementation DDPartyHeaderView

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color_BackColor;
         [self addSubview:self.titleLab];
         [self addSubview:self.moreBtn];
         [self addLayout];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"党务公开";
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
        _titleLab.textAlignment  =   NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
        [_moreBtn setTitleColor:color_RedColor forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moreBtn;
}


- (void)addLayout {
    
    YXWeakSelf
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.width.offset(100);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        [weakSelf.moreBtn sizeToFit];
    }];
}

- (void)moreBtnAction:(UIButton *)sender {
    
    if (self.clickMoreBtnBlock) {
        self.clickMoreBtnBlock(_indexPath);
    }
    
}

@end
