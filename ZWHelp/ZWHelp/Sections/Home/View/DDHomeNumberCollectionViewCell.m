//
//  DDHomeNumberCollectionViewCell.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDHomeNumberCollectionViewCell.h"
#import "DDHomeNumModel.h"
@interface DDHomeNumberCollectionViewCell ()
/**
 背景视图
 */
@property (nonatomic ,strong) UIView *backView;

/**
 标题
 */
@property (nonatomic ,strong) UILabel *titleLab;

/**
 内容
 */
@property (nonatomic ,strong) UILabel *contentLab;

/**
 图片
 */
@property (nonatomic ,strong) UIImageView *imgView;
@end

@implementation DDHomeNumberCollectionViewCell

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (_indexPath.row == 0) {
        _titleLab.text = @"网格数量";
        _imgView.image = [UIImage imageNamed:@"home_grid"];
    }else if (_indexPath.row == 1) {
        _titleLab.text = @"实有建筑";
        _imgView.image = [UIImage imageNamed:@"home_build"];
    }else if (_indexPath.row == 2) {
        _titleLab.text = @"实有住宅";
        _imgView.image = [UIImage imageNamed:@"home_residential"];
    }else if (_indexPath.row == 3) {
        _titleLab.text = @"公共建筑";
        _imgView.image = [UIImage imageNamed:@"home_publicBuildings"];
    }else if (_indexPath.row == 4) {
        _titleLab.text = @"实有房屋";
        _imgView.image = [UIImage imageNamed:@"home_house"];
    }else if (_indexPath.row == 5) {
        _titleLab.text = @"实有人口";
        _imgView.image = [UIImage imageNamed:@"home_population"];
    }else if (_indexPath.row == 6) {
        _titleLab.text = @"实有车辆";
        _imgView.image = [UIImage imageNamed:@"home_vehicle"];
    }else if (_indexPath.row == 7) {
        _titleLab.text = @"实有单位";
        _imgView.image = [UIImage imageNamed:@"home_unit"];
    }
}

- (void)setNumModel:(DDHomeNumModel *)numModel {
    _numModel = numModel;
    if (_indexPath.row == 0) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.gridNum];
    }else if (_indexPath.row == 1) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.buildNum];
    }else if (_indexPath.row == 2) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.houseNum];;
    }else if (_indexPath.row == 3) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.publicBuildingsNum];
    }else if (_indexPath.row == 4) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.propertyNum];
    }else if (_indexPath.row == 5) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.customerNum];;
    }else if (_indexPath.row == 6) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.carNum];;
    }else if (_indexPath.row == 7) {
        _contentLab.text = [NSString stringWithFormat:@"%ld",_numModel.unitNum];;
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLab];
        [self.backView addSubview:self.contentLab];
        [self.backView addSubview:self.imgView];
        [self addLayout];
    }
    return self;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 4;
    }
    return _backView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"成交额";
        _titleLab.textColor = color_TextThree;
        _titleLab.font = [UIFont systemFontOfSize:12.0f];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.text = @"0";
        _contentLab.textColor = color_TextOne;
        _contentLab.font = [UIFont systemFontOfSize:22.0f];
    }
    return _contentLab;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

#pragma mark - Layout
- (void)addLayout {
    
    YXWeakSelf
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10.0);
        make.height.equalTo(@17.0);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10.0);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(10);
        make.right.equalTo(@-10.0);
        make.height.equalTo(@22.0);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0.0);
        make.size.mas_equalTo(CGSizeMake(54, 54));
    }];
}


@end


