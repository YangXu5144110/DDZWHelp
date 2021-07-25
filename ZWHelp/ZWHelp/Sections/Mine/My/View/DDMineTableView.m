//
//  DDMineTableView.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/14.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDMineTableView.h"

@interface DDMineTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSArray *titlesArr;

@property (nonatomic ,strong) NSArray *titleImgArr;

@end

@implementation DDMineTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        self.separatorColor = [UIColor colorWithHexString:@"#F4F4F4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        
//        _titlesArr = @[@"我的消息",@"公告通知",@"使用帮助",@"建议反馈"];
//        _titleImgArr = @[@"mine_message",@"mine_notice",@"mine_help",@"mine_advice"];
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *versionString = [NSString stringWithFormat:@"当前版本：%@",appVersion];
        _titlesArr = @[@"我的消息",@"我是党员",versionString];
        _titleImgArr = @[@"mine_message",@"mine_party",@"min_version"];
        
    }
    return self;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"DDMineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.titleImgArr[indexPath.row]]];
    cell.textLabel.text= self.titlesArr[indexPath.row];
    if (indexPath.row == 0 || indexPath.row == 1) {
        UIImageView *rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        cell.accessoryView = rightImg;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.clickSelectRowAtIndexPath) {
        self.clickSelectRowAtIndexPath(indexPath);
    }
}

@end
