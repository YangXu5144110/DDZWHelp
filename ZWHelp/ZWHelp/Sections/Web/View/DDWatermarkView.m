//
//  DDWatermarkView.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/2.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDWatermarkView.h"

@interface DDWatermarkView ()

@property (nonatomic ,strong) UIView *timeView;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *weekLab;

@property (nonatomic ,strong) UIView *bottomView;
@property (nonatomic ,strong) UIImageView *usernameImg;
@property (nonatomic ,strong) UIImageView *locationImg;
@property (nonatomic ,strong) UILabel *usernameLab;
@property (nonatomic ,strong) UILabel *addressLab;
@end

@implementation DDWatermarkView

- (void)setAddress:(NSString *)address {
    _address = address;
    _addressLab.text = address?address:@"";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        _timeLab.text = [[ToolBox ddDateUtils] getCurrentTimesWithFormat:@"HH:mm"];
        _weekLab.text = [NSString stringWithFormat:@"%@ %@",[[ToolBox ddDateUtils] getCurrentTimesWithFormat:@"yyyy-MM-dd"],[[ToolBox ddDateUtils] getWeekdayStringFromDate]];
        _usernameLab.text = [DDUserInfoManager getUserInfo].userName;

    }
    return self;
}

- (UIView *)timeView {
    if (!_timeView) {
        _timeView = [UIView new];
        _timeView.backgroundColor = [UIColor blackColor];
        _timeView.alpha = 0.4;
        _timeView.layer.masksToBounds = YES;
        _timeView.layer.cornerRadius = 6.0;
    }
    return _timeView;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.font = [UIFont systemFontOfSize:24.0];
    }
    return _timeLab;
}

- (UILabel *)weekLab {
    if (!_weekLab) {
        _weekLab = [UILabel new];
        _weekLab.textColor = [UIColor whiteColor];
        _weekLab.font = [UIFont systemFontOfSize:12.0];
    }
    return _weekLab;
}


- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.4;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.layer.cornerRadius = 6.0;
    }
    return _bottomView;
}

- (UIImageView *)usernameImg {
    if (!_usernameImg) {
        _usernameImg = [UIImageView new];
        _usernameImg.image = [UIImage imageNamed:@"water_mine"];
    }
    return _usernameImg;
}

- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [UIImageView new];
        _locationImg.image = [UIImage imageNamed:@"water_location"];
    }
    return _locationImg;;
}

- (UILabel *)usernameLab {
    if (!_usernameLab) {
        _usernameLab = [UILabel new];
        _usernameLab.textColor = [UIColor whiteColor];
        _usernameLab.font = [UIFont systemFontOfSize:12.0];
    }
    return _usernameLab;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [UILabel new];
        _addressLab.text = @"中国河南省郑州市";
        _addressLab.textColor = [UIColor whiteColor];
        _addressLab.font = [UIFont systemFontOfSize:12.0];
    }
    return _addressLab;
}


- (void)setup {
    
    [self addSubview:self.timeView];
    [self.timeView addSubview:self.timeLab];
    [self.timeView addSubview:self.weekLab];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.usernameImg];
    [self.bottomView addSubview:self.locationImg];
    [self.bottomView addSubview:self.usernameLab];
    [self.bottomView addSubview:self.addressLab];
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.mas_top).offset(50);
        make.size.mas_equalTo(CGSizeMake(140, 64));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeView.mas_left).offset(15);
        make.top.equalTo(self.timeView.mas_top).offset(10);
        [self.timeLab sizeToFit];
    }];
    
    [_weekLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeView.mas_left).offset(15);
        make.top.equalTo(self.timeLab.mas_bottom).offset(5);
        [self.weekLab sizeToFit];
    }];
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.height.equalTo(@60);
    }];
    
    [_usernameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(15);
        make.top.equalTo(self.bottomView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(15);
        make.top.equalTo(self.usernameImg.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [_usernameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.usernameImg.mas_centerY);
        make.left.equalTo(self.usernameImg.mas_right).offset(10);
        [self.usernameLab sizeToFit];
    }];
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.locationImg.mas_centerY);
         make.left.equalTo(self.locationImg.mas_right).offset(10);
         [self.addressLab sizeToFit];
     }];
    
}




@end
