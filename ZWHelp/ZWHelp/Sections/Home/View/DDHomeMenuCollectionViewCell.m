//
//  DDHomeMenuCollectionViewCell.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDHomeMenuCollectionViewCell.h"

@interface DDHomeMenuCollectionViewCell ()

@property (strong, nonatomic) UIImageView *iconImage;

@property (strong, nonatomic) UILabel *nameLab;
@end

@implementation DDHomeMenuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color_BackColor;
        [self addLayout];
    }
    return self;
}
- (void)addLayout {
    [self addSubview:self.iconImage];
    [self addSubview:self.nameLab];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.iconImage.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
}

- (void)setMenuModel:(DDHomeMenuModel *)menuModel {
    _menuModel = menuModel;
    _nameLab.text = _menuModel.moduleName;
    if ([_menuModel.moduleName isEqualToString:@"全部"]) {
        _iconImage.image = _menuModel.moduleImg;
    }else {
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,_menuModel.pictureUrl];
        [_iconImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
    }
}


- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [UIImageView new];
        _iconImage.image = [UIImage imageNamed:@"home_all"];
    }
    return _iconImage;
}
- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = [UIColor colorWithHexString:@"434343"];
        _nameLab.font = [UIFont systemFontOfSize:12];
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}
@end
