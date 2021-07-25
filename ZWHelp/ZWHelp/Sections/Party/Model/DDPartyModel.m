//
//  DDPartyModel.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/5/25.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDPartyModel.h"

@implementation DDPartyModel


+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"attachmentList" : [DDPartyListModel class]};
}

- (void)setEntity:(NSDictionary *)entity {
    _entity = entity;
    _entityModel = [DDPartyEntityModel mj_objectWithKeyValues:_entity];
}



@end

@implementation DDPartyEntityModel

- (CGFloat)titleHeight {
    if (!_titleHeight) {
        CGFloat margin = 12.0;
        _titleHeight += margin;
        CGFloat contentH =[_relTitle boundingRectWithSize:CGSizeMake((KWIDTH -30),MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}context:nil].size.height;
        _titleHeight += contentH + margin;
    }
    return _titleHeight;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat margin = 15.0;
        _cellHeight += margin;
        CGFloat contentH =[_relContent boundingRectWithSize:CGSizeMake((KWIDTH -30),MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}context:nil].size.height;
        _cellHeight += contentH + margin;
    }
    return _cellHeight;
}

@end


@implementation DDPartyListModel

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    if (_filePath) {
        _filePath = [[_filePath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    }
}

- (void)setRemark:(NSString *)remark {
    _remark = remark;
    if (_remark) {
        _remark = [[_remark stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    }
}

@end


@implementation DDPartyTypeModel

@end
