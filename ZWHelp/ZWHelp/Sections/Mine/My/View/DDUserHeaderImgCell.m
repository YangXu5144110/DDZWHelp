//
//  DDUserHeaderImgCell.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDUserHeaderImgCell.h"

@implementation DDUserHeaderImgCell

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLab;
}

- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [UIImageView new];
        _headerImg.image = [UIImage imageNamed:@"mine_user_headerImg"];
        _headerImg.layer.masksToBounds = YES;
        _headerImg.layer.cornerRadius = 8.0f;
    }
    return _headerImg;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.headerImg];
        YXWeakSelf
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.left.equalTo(@20);
            [weakSelf.titleLab sizeToFit];
        }];
        
        [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.right.equalTo(@-10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    
    }
    return self;
}


@end
