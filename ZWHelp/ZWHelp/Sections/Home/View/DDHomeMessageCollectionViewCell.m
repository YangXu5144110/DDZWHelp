//
//  DDHomeMessageCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/4.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDHomeMessageCollectionViewCell.h"
#import <DateTools.h>

@interface DDHomeMessageCollectionViewCell ()
/**
 背景视图
 */
@property (nonatomic ,strong) UIView *backView;

/**
 图片
 */
@property (nonatomic ,strong) UIImageView *imgView;

/**
 标题
 */
@property (nonatomic ,strong) UILabel *titleLab;

/**
 内容
 */
@property (nonatomic ,strong) UILabel *contentLab;

/**
 箭头
*/
@property (nonatomic ,strong) UIImageView *arrowImgView;


@end

@implementation DDHomeMessageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.imgView];
        [self.backView addSubview:self.titleLab];
        [self.backView addSubview:self.arrowImgView];
        [self.backView addSubview:self.contentLab];
        [self addLayout];
    }
    return self;
}
- (void)setMessegeDic:(NSDictionary *)messegeDic{
    _messegeDic = messegeDic;
    NSInteger num = [messegeDic[@"num"] integerValue];
    _titleLab.text = [NSString stringWithFormat:@"你有%ld条未读消息",(long)num];
    NSString *time = messegeDic[@"sendTime"];
    _arrowImgView.hidden = num == 0;
    if (time) {
        NSDate *date = [DDDateUtils stringToDate:time withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        if (date) {
            _contentLab.text = [date timeAgoSinceNow];
        }else{
            _contentLab.text = @"";
        }
    }else{
        _contentLab.text = @"";

    }
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 8;
    }
    return _backView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"home_laba"];
    }
    return _imgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"你有0条未读消息";
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont systemFontOfSize:14.0f];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = color_TextThree;
        _contentLab.font = [UIFont systemFontOfSize:14.0f];
    }
    return _contentLab;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        _arrowImgView.image = [UIImage imageNamed:@"arrow_right"];
        _arrowImgView.hidden = YES;
    }
    return _arrowImgView;
}

#pragma mark - Layout
- (void)addLayout {
    
    YXWeakSelf
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.left.equalTo(weakSelf.backView.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.imgView.mas_centerY);
        make.left.equalTo(weakSelf.imgView.mas_right).offset(12);
        [weakSelf.titleLab sizeToFit];
    }];

    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.right.equalTo(weakSelf.backView.mas_right).offset(-12);
        make.size.mas_equalTo(CGSizeMake(6, 12));
    }];

    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.arrowImgView.mas_centerY);
        make.right.equalTo(weakSelf.arrowImgView.mas_left).offset(-12);
        [weakSelf.contentLab sizeToFit];
    }];
    
   
}


@end
