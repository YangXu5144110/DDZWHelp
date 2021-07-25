//
//  DDPartyDetailsFooterCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/26.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyDetailsFooterCollectionViewCell.h"
#import "DDPartyModel.h"
@implementation DDPartyDetailsFooterCollectionViewCell

- (void)setPartyModel:(DDPartyModel *)partyModel {
    _partyModel = partyModel;
    _contentLab.text = _partyModel.entityModel.relContent;
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

- (void)setup {
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@15);
        make.right.equalTo(@-15);
        [self.contentLab sizeToFit];
    }];
}
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = color_TextOne;
        _contentLab.font = [UIFont systemFontOfSize:14.0f];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}


@end
