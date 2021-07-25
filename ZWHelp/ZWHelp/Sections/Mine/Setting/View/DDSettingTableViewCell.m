//
//  DDSettingTableViewCell.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDSettingTableViewCell.h"
#import "DDSettingModel.h"
#import <UserNotifications/UserNotifications.h>
#import "SDImageCache.h"
@interface DDSettingTableViewCell ()

@property (nonatomic ,strong) NSArray *titlesArr;

@end

@implementation DDSettingTableViewCell

- (NSArray *)titlesArr {
    if (!_titlesArr) {
        _titlesArr = @[@[@"更改登录密码"],@[@"新消息通知",@"共享手机号码",@"非Wi-Fi下视频自动播放"],@[@"清除缓存",@"关于软件"]];
    }
    return _titlesArr;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    _titleLab.text = self.titlesArr[indexPath.section][indexPath.row];
    UIImageView *rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    _rightLab.hidden = YES;
    if (_indexPath.section == 0) {
        _isSwitch.hidden = YES;
        self.accessoryView = rightImg;
    }else if (_indexPath.section == 1) {
        _isSwitch.hidden = NO;
        if (_indexPath.row == 0) {
            _subTitleLab.text = @"关闭后将不会接收新消息通知";
            [self refreshSwitch];
        }else if (_indexPath.row == 1) {
            _subTitleLab.text = @"关闭后在通讯录中别人将无法查看手机号码";
        }else if (_indexPath.row == 2) {
            _isSwitch.on = NO;
        }
    }else if (_indexPath.section == 2) {
        _isSwitch.hidden = YES;
        if (indexPath.row == 0) {
            self.rightLab.hidden = NO;
            SDImageCache *sdImageCache = [SDImageCache sharedImageCache];
            NSString *cacheStr = [NSString stringWithFormat:@"%.2fM",    [sdImageCache totalDiskSize] /1000.0/1000.0];
            self.rightLab.text = cacheStr;
        }else {
            self.accessoryView = rightImg;
        }
    }
    
}
- (void)refreshSwitch {
    if (_indexPath.section == 1 && _indexPath.row == 0) {
        BOOL state = [UIApplication sharedApplication].registeredForRemoteNotifications;
        if (state) {
            _isSwitch.on = YES;
        }else {
            _isSwitch.on = NO;
        }
    }
}

- (void)setSetModel:(DDSettingModel *)setModel {
    _setModel = setModel;
    if (_indexPath.section == 1) {
        if (_indexPath.row == 1) {
            _isSwitch.on = setModel.isSharedPhone == 1 ? YES : NO;
        }
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.subTitleLab];
        [self.contentView addSubview:self.isSwitch];
        [self.contentView addSubview:self.rightLab];
        [self addLayout];
    }
    return self;
}

#pragma mark - Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.textColor = color_TextOne;
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc] init];
        _subTitleLab.font = [UIFont systemFontOfSize:10.0f];
        _subTitleLab.textColor = color_TextTwo;
    }
    return _subTitleLab;
}

- (UISwitch *)isSwitch {
    if (!_isSwitch) {
        _isSwitch = [[UISwitch alloc] init];
        _isSwitch.onTintColor = APPTintColor;
        _isSwitch.on = NO;
        [_isSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _isSwitch;
}

- (UILabel *)rightLab {
    if (!_rightLab) {
        _rightLab = [[UILabel alloc] init];
        _rightLab.font = [UIFont systemFontOfSize:14.0f];
        _rightLab.textColor = color_TextThree;
    }
    return _rightLab;
}

- (void)addLayout {
    
    YXWeakSelf
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        [weakSelf.titleLab sizeToFit];
    }];
    
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        [weakSelf.subTitleLab sizeToFit];

    }];
    
    [self.isSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        [weakSelf.rightLab sizeToFit];
    }];
    
}

- (void)valueChanged:(UISwitch *)switc{
    if (self.swtichOnOrOff) {
        self.swtichOnOrOff(switc.on);
    }
}
@end
