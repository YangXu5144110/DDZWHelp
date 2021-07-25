//
//  DDPartyDetailsHeaderCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyDetailsHeaderCollectionViewCell.h"
#import "DDPartyModel.h"
@interface DDPartyDetailsHeaderCollectionViewCell ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *createLab;
@property (nonatomic ,strong) UILabel *timeLab;

@end

@implementation DDPartyDetailsHeaderCollectionViewCell

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    self.titleLab.text = _partyModel.entityModel.relTitle;
    self.createLab.text = _partyModel.entityModel.organization;
    self.timeLab.text = _partyModel.entityModel.relDateTime;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.createLab];
    [self.contentView addSubview:self.timeLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(12);
        make.right.equalTo(self.mas_right).offset(-15);
        [self.titleLab sizeToFit];
    }];
    
    [_createLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(12);
        [self.createLab sizeToFit];
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.createLab.mas_centerY);
        make.left.equalTo(self.createLab.mas_right).offset(15);
        [self.timeLab sizeToFit];
    }];
    
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont boldSystemFontOfSize:17.0f];
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UILabel *)createLab {
    if (!_createLab) {
        _createLab = [[UILabel alloc] init];
        _createLab.textColor = color_TextThree;
        _createLab.font = [UIFont systemFontOfSize:12.0f];
    }
    return _createLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textColor = color_TextThree;
        _timeLab.font = [UIFont systemFontOfSize:12.0f];
    }
    return _timeLab;
}


@end
