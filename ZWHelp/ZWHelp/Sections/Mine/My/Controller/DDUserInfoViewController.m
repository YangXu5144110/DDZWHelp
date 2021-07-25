//
//  DDUserInfoViewController.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/15.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDUserInfoViewController.h"

#import "DDUserHeaderImgCell.h"
#import "DDUserBLL.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface DDUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (nonatomic ,strong) NSArray *titlesArr;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) YXCustomAlertActionView *alertView;
@property (nonatomic ,strong) DDUserInfoModel *infoModel;
@end

@implementation DDUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self customBackItemWithTitle:@"编辑资料" Image:[UIImage imageNamed:@"navi_back_black"]];
    
    self.infoModel = [DDUserInfoManager getUserInfo];
    
    [self loadSubViews];
}

- (void)loadSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titlesArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titlesArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 && indexPath.row == 0 ? 75 : 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        DDUserHeaderImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDUserHeaderImgCell"];
        if (!cell) {
            cell = [[DDUserHeaderImgCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"DDUserHeaderImgCell"];
        }
        cell.titleLab.text= self.titlesArr[indexPath.section][indexPath.row];
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,self.infoModel.headImg];
        [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mine_user_headerImg"]];
        return cell;

    }else {
        
        static NSString *cellID = @"YXUserInfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.textColor = color_TextOne;
        cell.textLabel.text= self.titlesArr[indexPath.section][indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section== 0 && indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.section == 0 ) {
            if (indexPath.row ==1) {
                cell.detailTextLabel.text = self.infoModel.userName?self.infoModel.userName:@"";
            }else if (indexPath.row == 2) {
                cell.detailTextLabel.text = self.infoModel.mobile?self.infoModel.mobile:@"";
            }else if (indexPath.row == 3) {
                cell.detailTextLabel.text = self.infoModel.sex == 1 ? @"男":@"女";
            }
        }else {
            if (indexPath.row ==0) {
                cell.detailTextLabel.text = self.infoModel.duty?self.infoModel.duty:@"";
            }else if (indexPath.row == 1) {
                cell.detailTextLabel.text = self.infoModel.unit?self.infoModel.unit:@"";
            }else if (indexPath.row == 2) {
                cell.detailTextLabel.text = self.infoModel.department?self.infoModel.department:@"";
            }
        }
        
        return cell;
        
    }
    return [[UITableViewCell alloc] init];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1
                                                                                              delegate:self];
        imagePicker.allowCrop = YES;
//        imagePicker.cropRect = CGRectMake(0, (kHEIGHT - (280 * KWIDTH/690))/2, KWIDTH,280 * KWIDTH/690 );
        [imagePicker setSortAscendingByModificationDate:NO];
        imagePicker.isSelectOriginalPhoto = YES;
        imagePicker.allowPickingVideo = NO;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePicker
                           animated:YES
                         completion:nil];
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        [self.alertView showAnimation];
    }
}

#pragma mark - TZImagePickerController Delegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    UIImage *seleImage = photos[0];
    [self uploadImageWithImage:seleImage];
}

#pragma mark - Lazy Loading
- (NSArray *)titlesArr {
    if (!_titlesArr) {
        _titlesArr = @[@[@"头像",@"姓名",@"手机号码",@"性别"],@[@"职务",@"单位名称",@"部门名称"]];
    }
    return _titlesArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = color_LineColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0 );
        _tableView.separatorColor = color_LineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [_tableView registerClass:[DDUserHeaderImgCell class] forCellReuseIdentifier:@"DDUserHeaderImgCell"];
    }
    return _tableView;
}

- (YXCustomAlertActionView *)alertView {
    if (!_alertView) {
        _alertView = [[YXCustomAlertActionView alloc] initWithFrame:[UIScreen mainScreen].bounds ViewType:(AlertTextTable) Title:@"修改性别" Message:@"" sureBtn:@"" cancleBtn:@""];
        [_alertView setListArr:@[@"男",@"女"]];
        YXWeakSelf
        [_alertView setSureClick:^(NSString * _Nonnull string) {
            if ([string isEqualToString:@"男"]) {
                [weakSelf requestUpdateSex:@"1"];
            }else {
                [weakSelf requestUpdateSex:@"2"];
            }
        }];
    }
    return _alertView;
}


#pragma mark -- 上传头像
- (void)uploadImageWithImage:(UIImage *)image  {
    
    YXWeakSelf
    [YJProgressHUD showLoading:@"正在上传中..."];
    [[DDUserBLL sharedUserBLL] uploadHeadImgWithImage:image Success:^(id  _Nonnull responseObject) {
        [YJProgressHUD showMessage:@"修改成功"];
        [DDUserInfoManager resetUserInfoMessageWithDic:@{@"headImg":responseObject[@"data"]}];
        [weakSelf.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationImageUrl object:nil userInfo:nil];
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
        
}

#pragma mark -- 修改用户性别
- (void)requestUpdateSex:(NSString *)sex {

    YXWeakSelf
    [YJProgressHUD showLoading:@""];
    [[DDUserBLL sharedUserBLL] updatePersonInfoWithSex:sex onUpdateSexSuccess:^{
        [YJProgressHUD showMessage:@"修改成功"];
        [DDUserInfoManager resetUserInfoMessageWithDic:@{@"sex":sex}];
        [weakSelf.tableView reloadData];
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
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
