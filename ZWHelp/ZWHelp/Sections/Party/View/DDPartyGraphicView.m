//
//  DDPartyGraphicView.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyGraphicView.h"
#import "DDPartyModel.h"
#import <UIImage+ColorImage.h>
@interface DDPartyGraphicView ()

@property (nonatomic ,strong) UIView *imgBgView;
@property (nonatomic ,strong) UIImageView *imgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *createLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *numLab;
@property (nonatomic ,strong) UIView *lineView;

@end

@implementation DDPartyGraphicView

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    
    if (_partyModel.attachmentList.count == 0) {
        [self setTypeView:GraphicStateNormal];
    }else if (_partyModel.attachmentList.count > 0) {
        [self setTypeView:GraphicStateSingle];
        DDPartyListModel *listModel = _partyModel.attachmentList[0];
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.filePath];
        if (_partyModel.attachmentList.count > 1) {
            self.numLab.text = [NSString stringWithFormat:@"%ld",_partyModel.attachmentList.count];
        }
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
        
//    }else if (_partyModel.attachmentList.count > 1) {
//        [self setTypeView:GraphicStateMore];
//        if (_partyModel.attachmentList.count > 3) {
//            NSArray *smallArray = [_partyModel.attachmentList subarrayWithRange:NSMakeRange(0, 3)];
//            [self createImgView:smallArray];
//        }else {
//            [self createImgView:_partyModel.attachmentList];
//        }
    }
    
    self.titleLab.text = _partyModel.entityModel.relTitle;
    self.createLab.text = _partyModel.entityModel.organization;
    self.timeLab.text = _partyModel.entityModel.relDateTime;

}

- (void)createImgView:(NSArray *)arr {
    
    NSMutableArray *viewArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i ++) {
        DDPartyListModel *listModel = [arr objectAtIndex:i];
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor redColor];
        [self addSubview:imgView];
        [viewArr addObject:imgView];
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,listModel.filePath];
        [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    
    
    // 实现masonry水平固定间隔方法
    [viewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:15 tailSpacing:15];

    
    // 设置array的垂直方向的约束
    [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@67);
        make.height.equalTo(@75);
    }];
    
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgBgView];
        [self.imgBgView addSubview:self.imgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.createLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.numLab];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)setTypeView:(GraphicViewType)type {

    YXWeakSelf
    if (type == GraphicStateNormal) {
        _imgBgView.hidden = YES;
        _imgView.hidden = YES;
        _titleLab.hidden = NO;
        [_titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.top.equalTo(weakSelf.mas_top).offset(16);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.height.equalTo(@40);
        }];
                
    }else if (type == GraphicStateSingle) {
        _imgBgView.hidden = NO;
        _imgView.hidden = NO;
        _titleLab.hidden = NO;
        [_imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(105, 75));
        }];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.imgBgView.mas_right).offset(-6);
            make.bottom.equalTo(weakSelf.imgBgView.mas_bottom).offset(-6);
            [weakSelf.numLab sizeToFit];
        }];
        
        [_titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.top.equalTo(weakSelf.mas_top).offset(16);
            make.right.equalTo(weakSelf.mas_right).offset(-143);
            make.height.equalTo(@40);
        }];
                        
    }else if (type == GraphicStateMore) {
        _imgView.hidden = YES;
        _titleLab.hidden = NO;
        [_titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.top.equalTo(weakSelf.mas_top).offset(16);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.height.equalTo(@40);
        }];
        
    }
    
    [_createLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-16);
        make.size.mas_equalTo(CGSizeMake(103, 20));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.createLab.mas_centerY);
        make.left.equalTo(weakSelf.createLab.mas_right).offset(10);
        [weakSelf.timeLab sizeToFit];
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
}

- (UIView *)imgBgView {
    if (!_imgBgView) {
        _imgBgView = [UIView new];
        _imgBgView.layer.masksToBounds = YES;
        _imgBgView.layer.cornerRadius = 5.0f;
        _imgBgView.hidden = YES;
    }
    return _imgBgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 5.0f;
        _imgView.hidden = YES;
    }
    return _imgView;
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


- (UILabel *)createLab {
    if (!_createLab) {
        _createLab = [[UILabel alloc] init];
        _createLab.backgroundColor = [UIColor colorWithHexString:@"#FCEBEB"];;
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

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.textColor = [UIColor whiteColor];
        _numLab.font = [UIFont systemFontOfSize:10.0f];
    }
    return _numLab;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = color_LineColor;
    }
    return _lineView;
}

@end
