//
//  DDPublicPopupViewController.m
//  ZWHelp
//
//  Created by 杨旭 on 2021/2/1.
//  Copyright © 2021 杨旭. All rights reserved.
//

#import "DDPublicPopupViewController.h"
#import <HWPop.h>
#import "DDStarModel.h"
@interface DDPublicPopupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) DDPeriodModel *periodModel;
@property (nonatomic,strong) DDStarModel *starModel;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation DDPublicPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.type == 0) {
        self.title = @"评定周期";
    }else if (self.type == 1) {
        self.title = @"星级等级";
    }
    
    self.contentSizeInPop = CGSizeMake(KWIDTH, 300);
    self.contentSizeInPopWhenLandscape = CGSizeMake(KWIDTH, 300);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_down"] style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self loadSubViews];
    
}

- (void)click {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadSubViews {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"DDPopupTableViewCell";
    DDPopupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DDPopupTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    if (self.type == 0) {
        DDPeriodModel *periodModel = self.listArr[indexPath.row];
        cell.titleLab.text = periodModel.period;
        cell.selectBtn.selected = periodModel.selected;
    }else {
        DDStarModel *starModel = self.listArr[indexPath.row];
        cell.titleLab.text = starModel.grade;
        cell.selectBtn.selected = starModel.selected;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        self.periodModel = self.listArr[indexPath.row];
        for (DDPeriodModel *periodModel in self.listArr) {
            if ([periodModel.period isEqualToString:self.periodModel.period]) {
                periodModel.selected = YES;
            }else {
                periodModel.selected = NO;
            }
        }
     }else {
         self.starModel = self.listArr[indexPath.row];
         for (DDStarModel *starModel in self.listArr) {
             if ([starModel.grade isEqualToString:self.starModel.grade]) {
                 starModel.selected = YES;
             }else {
                 starModel.selected = NO;
             }
         }
     }
    [self.tableView reloadData];
    
    if (self.clickSelectIndex) {
        self.clickSelectIndex(indexPath);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        _tableView.separatorColor = color_LineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation DDPopupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}
- (void)setup {
    
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.titleLab];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.selectBtn.mas_right).offset(15);
    }];
  
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor darkTextColor];
        _titleLab.text = @"2021-01-01 至 2021-01-31";
    }
    return _titleLab;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectBtn setImage:[UIImage imageNamed:@"pop_unselect"] forState:(UIControlStateNormal)];
        [_selectBtn setImage:[UIImage imageNamed:@"pop_select"] forState:(UIControlStateSelected)];
        _selectBtn.userInteractionEnabled = NO;
    }
    return _selectBtn;
}


@end
