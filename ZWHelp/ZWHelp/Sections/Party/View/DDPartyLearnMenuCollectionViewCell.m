//
//  DDPartyLearnMenuCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/17.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyLearnMenuCollectionViewCell.h"

@interface DDPartyLearnMenuCollectionViewCell ()

@property (strong, nonatomic) UIButton *btn;

@end

@implementation DDPartyLearnMenuCollectionViewCell

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    switch (_indexPath.row) {
        case 0: {
            [_btn setTitle:@"党章党规" forState:(UIControlStateNormal)];
        }
            break;
        case 1: {
            [_btn setTitle:@"系列讲话" forState:(UIControlStateNormal)];
        }
            break;
            
        default:
            break;
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
- (void)addLayout {
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(170, 40));
    }];
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_btn setBackgroundColor:color_RedColor];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 6;
        _btn.userInteractionEnabled = NO;
    }
    return _btn;
}

@end
