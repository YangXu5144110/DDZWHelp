//
//  DDPartyDetailsContentCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyDetailsContentCollectionViewCell.h"
#import "DDPartyModel.h"

@interface DDPartyDetailsContentCollectionViewCell ()
@property (nonatomic ,strong) UIView *playView;
@property (nonatomic ,strong) UIImageView *videoImgView;
@property (nonatomic ,strong) UIButton *playBtn;
@end

@implementation DDPartyDetailsContentCollectionViewCell

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    if (_partyModel.attachmentList.count > 0) {
         DDPartyListModel *listModel = _partyModel.attachmentList[0];
         NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.remark];
         [self.videoImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
     }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.playView];
    [self.playView addSubview:self.videoImgView];
    [self.playView addSubview:self.playBtn];
 
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_videoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playView.mas_centerY);
        make.centerX.equalTo(self.playView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
}

- (UIView *)playView {
    if (!_playView) {
        _playView = [UIView new];
        _playView.backgroundColor = [UIColor blackColor];
        _playView.layer.masksToBounds = YES;

    }
    return _playView;
}

- (UIImageView *)videoImgView {
    if (!_videoImgView) {
        _videoImgView = [UIImageView new];
        _videoImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _videoImgView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_playBtn setImage:[UIImage imageNamed:@"video_play"] forState:(UIControlStateNormal)];
        [_playBtn addTarget:self action:@selector(playBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _playBtn;
}

- (void)playBtnAction {
    if (self.clickplayBtnBlock) {
        self.clickplayBtnBlock();
    }
    
}


@end
