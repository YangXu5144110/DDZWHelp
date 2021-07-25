//
//  DDPartyBannceCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/25.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyContentCollectionViewCell.h"
#import "DDPartyGraphicView.h"
#import "DDPartyVideoView.h"
#import "DDPartyImageView.h"
#import "DDPartyModel.h"
@interface DDPartyContentCollectionViewCell ()
@property (nonatomic ,strong) DDPartyGraphicView *graphicView;
@property (nonatomic ,strong) DDPartyVideoView *videoView;
@property (nonatomic ,strong) DDPartyImageView *imageView;

@end

@implementation DDPartyContentCollectionViewCell


- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
//    _videoView.playView.tag = _indexPath.row+1;
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
}

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    
    if (_partyModel.entityModel.relType1 == 1) {
        self.graphicView.hidden = NO;
        self.videoView.hidden = YES;
        self.imageView.hidden = YES;
        self.graphicView.partyModel = self.partyModel;
    }else if (_partyModel.entityModel.relType1 == 2) {
        self.graphicView.hidden = YES;
        self.videoView.hidden = YES;
        self.imageView.hidden = NO;
        self.imageView.partyModel = self.partyModel;
    }else if (_partyModel.entityModel.relType1 == 3) {
        self.graphicView.hidden = YES;
        self.videoView.hidden = NO;
        self.imageView.hidden = YES;
        self.videoView.partyModel = self.partyModel;
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addLayout];
    }
    return self;
}

- (DDPartyGraphicView *)graphicView {
    if (!_graphicView) {
        _graphicView = [[DDPartyGraphicView alloc] initWithFrame:CGRectZero];
        _graphicView.hidden = YES;
    }
    return _graphicView;;
}

- (DDPartyVideoView *)videoView {
    if (!_videoView) {
        _videoView = [[DDPartyVideoView alloc] initWithFrame:CGRectZero];
        _videoView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [_videoView.videoImgView addGestureRecognizer:tap];
    }
    return _videoView;;
}
- (DDPartyImageView *)imageView {
    if (!_imageView) {
        _imageView = [[DDPartyImageView alloc] initWithFrame:CGRectZero];
        _imageView.hidden = YES;
    }
    return _imageView;
}


- (void)addLayout {
    
    [self.contentView addSubview:self.graphicView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.videoView];
    [_graphicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)click{
    if (self.clickPlayBlock) {
        self.clickPlayBlock();
    }
}

@end
