//
//  DDAffairsCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/23.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDAffairsCollectionViewCell.h"
#import "DDAffairsGroupModel.h"
@interface DDAffairsCollectionViewCell ()

/**
 背景图
 */
@property (nonatomic ,strong) UIView *backView;
/**
 icon图片
 */
@property (nonatomic ,strong) UIImageView *iconImageView;
/**
 名称
 */
@property (nonatomic ,strong) UILabel *titleLab;
/**
 数量
 */
@property (nonatomic ,strong) UILabel *numLab;

@end

@implementation DDAffairsCollectionViewCell

- (void)setModel:(DDAffairsModel *)model {
    _model = model;
    
    _titleLab.text = _model.moduleName;
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,_model.pictureUrl];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
    NSInteger msgNum = [_model.msgNum integerValue];
    if (msgNum == 0) {
        _numLab.hidden = YES;
    }else if (msgNum > 99) {
        _numLab.hidden = NO;
        _numLab.text = @"99+";
    }else {
        _numLab.hidden = NO;
        _numLab.text = _model.msgNum;
    }
    
    [self changeMsgNumLabWithFrame:msgNum];
}

// 改变消息数量控件大小
- (void)changeMsgNumLabWithFrame:(NSInteger)msgNum {
    if (msgNum>9) {
        [_numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(-12);
            make.top.equalTo(self.iconImageView.mas_top).offset(-7);
            make.size.mas_equalTo(CGSizeMake(24, 14));
        }];
    }else {
        [_numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(-12);
            make.top.equalTo(self.iconImageView.mas_top).offset(-7);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpLayout];
    }
    return self;
}

/**
 页面布局
 */
- (void)setUpLayout{
    [self addSubview:self.backView];
    [self.backView addSubview:self.iconImageView];
    [self.backView addSubview:self.titleLab];
    [self.backView addSubview:self.numLab];

    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backView.mas_top).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-12);
    }];
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(-12);
        make.top.equalTo(self.iconImageView.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(24, 14));
    }];
    
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"notice_important"];
    }
    return _iconImageView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont systemFontOfSize:12.0f];
    }
    return _titleLab;
}
- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.backgroundColor = [UIColor redColor];
        _numLab.textAlignment = NSTextAlignmentCenter;
        _numLab.textColor = [UIColor whiteColor];
        _numLab.font = [UIFont systemFontOfSize:12.0f];
        _numLab.layer.masksToBounds = YES;
        _numLab.layer.cornerRadius = 7;
    }
    return _numLab;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [UIView new];
        //        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
@end
