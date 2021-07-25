//
//  DDStarLevelCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2021/1/30.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDStarLevelCollectionViewCell.h"

@interface DDStarLevelCollectionViewCell ()

@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *subTitleLab;
@property (nonatomic ,strong) UIImageView *rightImg;
@end

@implementation DDStarLevelCollectionViewCell

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (_indexPath.section == 0) {
        _titleLab.text = @"评定周期";
    }else {
        _titleLab.text = @"星级等级";
    }
}

- (void)setContent:(NSString *)content {
    _content = content;
    if (_indexPath.section == 0) {
        if (_content) {
            _subTitleLab.text = _content;
            _subTitleLab.textColor = color_TextOne;
        }else {
            _subTitleLab.text = @"请选择";
            _subTitleLab.textColor = color_TextThree;
        }
    }else {
        if (_content) {
            _subTitleLab.text = _content;
            _subTitleLab.textColor = color_TextOne;
        }else {
            _subTitleLab.text = @"请选择";
            _subTitleLab.textColor = color_TextThree;
        }
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color_BackColor;
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLab];
        [self.backView addSubview:self.subTitleLab];
        [self.backView addSubview:self.rightImg];
        [self addLayout];
    }
    return self;
}

- (void)addLayout {
    
    DDWeakSelf
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).offset(13);
        make.top.equalTo(weakSelf.backView.mas_top).offset(16);
        make.height.equalTo(@16);
    }];
    
    [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).offset(13);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(16);
        make.height.equalTo(@16);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.right.equalTo(weakSelf.backView.mas_right).offset(-12);
        make.size.mas_equalTo(CGSizeMake(6, 12));
    }];
    
}


- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 12.0f;
    }
    return _backView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"你有0条未读消息";
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc] init];
        _subTitleLab.text = @"你有0条未读消息";
        _subTitleLab.textColor = color_TextOne;
        _subTitleLab.font = [UIFont systemFontOfSize:16.0f];
    }
    return _subTitleLab;
}
- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [UIImageView new];
        _rightImg.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _rightImg;
}

@end
