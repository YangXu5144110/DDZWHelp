//
//  DDChangePwdTableViewCell.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDChangePwdTableViewCell.h"

@interface DDChangePwdTableViewCell ()<UITextFieldDelegate>

/** 标题*/
@property (nonatomic ,strong) UILabel *titleLab;
/** 输入框*/
@property (nonatomic ,strong) LTLimitTextField *inputTF;

@end

@implementation DDChangePwdTableViewCell

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    if (_indexPath.row == 0) {
        _titleLab.text = @"原密码";
        _inputTF.placeholder = @"请填写原密码";
    }else if (_indexPath.row == 1) {
        _titleLab.text = @"新密码";
        _inputTF.placeholder = @"请填写新密码";
    }else if (_indexPath.row == 2) {
        _titleLab.text = @"确认密码";
        _inputTF.placeholder = @"请再次填写确认";
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.inputTF];
        [self addLayout];
    }
    return self;
}

#pragma mark - Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.textColor = color_TextOne;
    }
    return _titleLab;
}

- (LTLimitTextField *)inputTF {
    if (!_inputTF) {
        _inputTF = [[LTLimitTextField alloc] init];
        _inputTF.font = [UIFont systemFontOfSize:14];
        _inputTF.delegate = self;
        _inputTF.borderStyle = UITextBorderStyleNone;
        _inputTF.keyboardType = UIKeyboardTypeASCIICapable;
//        self.psdTF.secureTextEntry = YES;
        _inputTF.textLimitType = LTTextLimitTypeLength;
        _inputTF.textLimitSize = 16;
        [_inputTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTF;
}

- (void)addLayout {
    
    YXWeakSelf
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(24);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.height.equalTo(@16);
        [weakSelf.titleLab sizeToFit];
    }];
    
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.bottom.equalTo(weakSelf.mas_bottom);
        [weakSelf.inputTF sizeToFit];
    }];
    
    
}

- (void)textFieldChanged:(LTLimitTextField *)sender {
    if (self.editTextBlock) {
        self.editTextBlock(sender.text);
    }
}

@end
