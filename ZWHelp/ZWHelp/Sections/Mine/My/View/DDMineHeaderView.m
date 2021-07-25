//
//  DDMineHeaderView.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDMineHeaderView.h"

@interface DDMineHeaderView ()

@property (nonatomic ,strong) UIImageView *headerImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *dutyLab;
@property (nonatomic ,strong) UIImageView *nextImg;

@end

@implementation DDMineHeaderView

- (void)setInfoModel:(DDUserInfoModel *)infoModel {
    _infoModel = infoModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,[DDUserInfoManager getUserInfo].headImg];
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mine_user_headerImg"]];
    
    _nameLab.text = _infoModel.userName;
    
    _dutyLab.text = _infoModel.duty;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headerImg];
        [self addSubview:self.nameLab];
        [self addSubview:self.dutyLab];
        [self addSubview:self.nextImg];
        [self addLayout];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


#pragma mark - Lazy Loading
- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [UIImageView new];
        _headerImg.image = [UIImage imageNamed:@"mine_user_headerImg"];
        _headerImg.layer.masksToBounds = YES;
        _headerImg.layer.cornerRadius = 8.0f;
    }
    return _headerImg;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = color_TextOne;
        _nameLab.font = [UIFont boldSystemFontOfSize:20.0f];
        _nameLab.text = @"张玲玲";
    }
    return _nameLab;
}

- (UILabel *)dutyLab {
    if (!_dutyLab) {
        _dutyLab = [UILabel new];
        _dutyLab.textColor = color_TextThree;
        _dutyLab.font = [UIFont systemFontOfSize:14.0f];
        _dutyLab.text = @"市委书记";
    }
    return _dutyLab;
}

- (UIImageView *)nextImg {
    if (!_nextImg) {
        _nextImg = [UIImageView new];
        _nextImg.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _nextImg;
}

- (void)addLayout {
    
    YXWeakSelf
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerImg.mas_top);
        make.left.equalTo(weakSelf.headerImg.mas_right).offset(15);
        [weakSelf.nameLab sizeToFit];
    }];

    [self.dutyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImg.mas_right).offset(15);
        make.bottom.equalTo(weakSelf.headerImg.mas_bottom);
        [weakSelf.dutyLab sizeToFit];
    }];

    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.dutyLab.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    
}

- (void)click {
    
    if (self.pushUserInfoVC) {
        self.pushUserInfoVC();
    }
}

@end
