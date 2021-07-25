//
//  DDPartyImageView.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyImageView.h"
#import "DDPartyModel.h"
#import <UIImage+ColorImage.h>
@interface DDPartyImageView ()
@property (nonatomic ,strong) UIImageView *imgView;
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) UILabel *imgTitleLab;
@property (nonatomic ,strong) UIView *lineView;
@end

@implementation DDPartyImageView

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    
    if (_partyModel.attachmentList.count > 0) {
        DDPartyListModel *listModel = _partyModel.attachmentList[0];
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.filePath];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    self.imgTitleLab.text = _partyModel.entityModel.relTitle;
    
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

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"image_placeholder"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}

- (UILabel *)imgTitleLab {
    if (!_imgTitleLab) {
        _imgTitleLab = [[UILabel alloc] init];
        _imgTitleLab.textColor = color_TextOne;
        _imgTitleLab.font = [UIFont boldSystemFontOfSize:18.0f];
    }
    return _imgTitleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = color_LineColor;
    }
    return _lineView;
}


- (void)setup {
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.imgTitleLab];
    [self addSubview:self.lineView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@232);
    }];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@40);
    }];
    [_imgTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.left.equalTo(self.titleView.mas_left).offset(15);
        make.right.equalTo(self.titleView.mas_right).offset(-15);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
           
}


@end
