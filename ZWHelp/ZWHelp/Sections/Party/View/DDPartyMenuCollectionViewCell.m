//
//  DDPartyMenuCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/15.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyMenuCollectionViewCell.h"

@interface DDPartyMenuCollectionViewCell ()

@property (strong, nonatomic) UIImageView *iconImage;

@property (strong, nonatomic) UILabel *nameLab;

@end

@implementation DDPartyMenuCollectionViewCell

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    switch (_indexPath.row) {
        case 0: {
            _iconImage.image = [UIImage imageNamed:@"party_wish"];
            _nameLab.text = @"微心愿";
        }
            break;
        case 1: {
            _iconImage.image = [UIImage imageNamed:@"party_reports"];
            _nameLab.text = @"双报到";
        }
            break;
        case 2: {
            _iconImage.image = [UIImage imageNamed:@"party_learning"];
            _nameLab.text = @"两学一做";
        }
            break;
        case 3: {
            _iconImage.image = [UIImage imageNamed:@"party_will"];
            _nameLab.text = @"三会一课";
        }
            break;
            
        default:
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addLayout];
    }
    return self;
}
- (void)addLayout {
    [self addSubview:self.iconImage];
    [self addSubview:self.nameLab];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 26));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.iconImage.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [UIImageView new];
    }
    return _iconImage;
}
- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = color_TextOne;
        _nameLab.font = [UIFont systemFontOfSize:12];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.text= @"建筑采集";
    }
    return _nameLab;
}

@end
