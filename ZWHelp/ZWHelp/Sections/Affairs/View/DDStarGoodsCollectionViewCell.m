//
//  DDStarGoodsCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2021/1/30.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDStarGoodsCollectionViewCell.h"
#import "DDStarModel.h"
#import "XHStarRateView.h"
@interface DDStarGoodsCollectionViewCell ()

@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UIImageView *goodsImgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *scoreLab;
@property (nonatomic, strong) XHStarRateView *shopStarView;
@end

@implementation DDStarGoodsCollectionViewCell

- (void)setGoodsModel:(DDStarGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    NSString *url = [NSString stringWithFormat:@"%@",_goodsModel.filePath];
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"merchant_placeholder"]];
    _titleLab.text = _goodsModel.merchantName;
    _shopStarView.currentScore = _goodsModel.grade;
    _scoreLab.text = [NSString stringWithFormat:@"总分值：%ld",_goodsModel.score];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color_BackColor;
        [self.contentView addSubview:self.backView];
        [self.contentView addSubview:self.goodsImgView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.scoreLab];
        [self addLayout];
        
        _shopStarView = [[XHStarRateView alloc] initWithFrame:(CGRectMake(144, 70, 80, 20))];
        _shopStarView.rateStyle = WholeStar;
        _shopStarView.userInteractionEnabled = NO;
        [self.backView addSubview:self.shopStarView];
        
    }
    return self;
}


- (void)addLayout {
    
    DDWeakSelf
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    
    [_goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView);
        make.left.equalTo(weakSelf.backView.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(120, 90));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodsImgView.mas_top);
        make.left.equalTo(weakSelf.goodsImgView.mas_right).offset(12);
        make.right.equalTo(weakSelf.backView.mas_right).offset(-15);
    }];
    
    [_scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.goodsImgView.mas_bottom);
        make.left.equalTo(weakSelf.goodsImgView.mas_right).offset(12);
        make.right.equalTo(weakSelf.backView.mas_right).offset(-15);
    }];
}


- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 12.0f;
    }
    return _backView;
}
- (UIImageView *)goodsImgView {
    if (!_goodsImgView) {
        _goodsImgView = [UIImageView new];
        _goodsImgView.image = [UIImage imageNamed:@"merchant_placeholder"];
    }
    return _goodsImgView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
        _titleLab.text = @"商户名称：沙县小吃黄焖鸡米饭";
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UILabel *)scoreLab {
    if (!_scoreLab) {
        _scoreLab = [[UILabel alloc] init];
        _scoreLab.textColor = color_TextTwo;
        _scoreLab.font = [UIFont systemFontOfSize:14.0f];
        _scoreLab.text = @"总分值：0";
    }
    return _scoreLab;
}


@end
