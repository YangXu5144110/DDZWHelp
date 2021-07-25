//
//  DDPartyVideoView.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyVideoView.h"
#import "DDPartyModel.h"
@interface DDPartyVideoView ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIView *playView;
@property (nonatomic ,strong) UIButton *playBtn;
@property (nonatomic ,strong) UILabel *createLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIView *lineView;

@end

@implementation DDPartyVideoView

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    if (_partyModel.attachmentList.count > 0) {
        DDPartyListModel *listModel = _partyModel.attachmentList[0];
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.remark];
        [self.videoImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        
    }
    self.titleLab.text = _partyModel.entityModel.relTitle;
    self.createLab.text = _partyModel.entityModel.organization;
    self.timeLab.text = _partyModel.entityModel.relDateTime;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = color_TextOne;
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UIView *)playView {
    if (!_playView) {
        _playView = [UIView new];
        _playView.layer.masksToBounds = YES;
        _playView.layer.cornerRadius = 8.0f;
        _playView.backgroundColor = [UIColor blackColor];
        _playView.userInteractionEnabled = YES;
    }
    return _playView;
}

- (DDPlayerSuperImageView *)videoImgView {
    if (!_videoImgView) {
        _videoImgView = [DDPlayerSuperImageView new];
        _videoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImgView.backgroundColor = UIColor.clearColor;
        _videoImgView.layer.masksToBounds = YES;
        _videoImgView.userInteractionEnabled = YES;
    }
    return _videoImgView;
}


- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_playBtn setImage:[UIImage imageNamed:@"video_play"] forState:(UIControlStateNormal)];
        _playBtn.userInteractionEnabled = NO;
    }
    return _playBtn;
}

- (UILabel *)createLab {
    if (!_createLab) {
        _createLab = [[UILabel alloc] init];
        _createLab.backgroundColor = [UIColor colorWithHexString:@"#FCEBEB"];
        _createLab.textColor = APPTintColor;
        _createLab.font = [UIFont systemFontOfSize:12.0f];
        _createLab.layer.cornerRadius = 10;
        _createLab.layer.masksToBounds = YES;
        _createLab.textAlignment= NSTextAlignmentCenter;
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

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = color_LineColor;
    }
    return _lineView;
}

- (void)setup {
    [self addSubview:self.titleLab];
    [self addSubview:self.playView];
    [self.playView addSubview:self.videoImgView];
    [self.videoImgView addSubview:self.playBtn];
    [self addSubview:self.createLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.lineView];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(12);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@40);
    }];
    
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@198);
    }];

    [_videoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.videoImgView.mas_centerY);
        make.centerX.equalTo(self.videoImgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    [_createLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.playView.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(103, 20));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.createLab.mas_centerY);
        make.left.equalTo(self.createLab.mas_right).offset(10);
        [self.timeLab sizeToFit];
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
}


@end
