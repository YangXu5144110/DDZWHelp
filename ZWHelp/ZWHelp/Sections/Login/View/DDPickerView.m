//
//  DDPickerView.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/18.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDPickerView.h"
#import "DDCRMModel.h"

#define LTColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(argbValue) [UIColor colorWithRed:((float)((argbValue & 0x00FF0000) >> 16))/255.0 green:((float)((argbValue & 0x0000FF00) >> 8))/255.0 blue:((float)(argbValue & 0x000000FF))/255.0 alpha:((float)((argbValue & 0xFF000000) >> 24))/255.0]

@interface DDPickerView ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIWindow *_window;
    UITapGestureRecognizer *_gesture;
    UIView *_view;
    UIView*_headView;

}

@property (strong, nonatomic) UIView * select;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIView  * all;
@property (strong, nonatomic) UILabel * allText;
@property (strong, nonatomic) UISwitch * allSwithch;
@property (assign, nonatomic) NSInteger  num;
@property (strong, nonatomic) NSMutableArray * midArry;


@end

@implementation DDPickerView

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    _midArry = _dataArr;
    [_tableView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame midArry:(NSMutableArray *)midArry{
    
    self = [super initWithFrame:frame];
    if (self) {
        _midArry = midArry;
        [_tableView reloadData];
    }
    return self;
}

#pragma mark 打开与关闭方法
-(void)show{
    
    [self setUI];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, kHEIGHT - 300, KWIDTH, 300);
    }];
    
}

-(void)close{
    //移除点击手势
    [_window removeGestureRecognizer:_gesture];
    _gesture = nil;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, kHEIGHT, KWIDTH, 300);
    } completion:^(BOOL finished) {
        
        for(id subv in [self subviews])
        {
            [subv removeFromSuperview];
        }
        [_view removeFromSuperview];
    }];
}

- (void)setUI{
    
    self.frame = CGRectMake(0, kHEIGHT, KWIDTH, 300);
    
    _num = _midArry.count;
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:topView];
    
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.frame = CGRectMake(15, 0, 40, 50);
    [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftbtnOnclick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.frame = CGRectMake(60, 0, KWIDTH-120, 50);
    titleLable.text = _title;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.textColor = [UIColor blackColor];
    [topView addSubview:titleLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, KWIDTH, 1)];
        [lineView setBackgroundColor:color_LineColor];
    [topView addSubview:lineView];

    self.select = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KWIDTH, 250)];
    [self addSubview:self.select];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 250) style:UITableViewStyleGrouped];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.separatorColor = color_LineColor;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.bounces=NO;
    _tableView.userInteractionEnabled=YES;
    _tableView.dataSource=self;
    [ self.select addSubview:_tableView];
    
    self.select.userInteractionEnabled=YES;
   
    _window = [UIApplication sharedApplication].keyWindow;
    _window.frame=CGRectMake(0, 0, KWIDTH, kHEIGHT);
    [_window addSubview:self];
    _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    _gesture.delegate=self;
    [_window addGestureRecognizer:_gesture];
    _view = [[UIView alloc]initWithFrame:_window.bounds];
    _view.backgroundColor = LTColor(0, 0, 0, 0.6);
 
    [_window addSubview:_view];
    [_view addSubview:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%@",[touch.view class]);
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]||[NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {//如果当前是tableView
        return NO;
    }
    return YES;
}

#pragma mark tableView数据源和代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _midArry.count;
}
//cell高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"XiaoddXiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    DDCRMModel*model=_midArry[indexPath.row];
    UILabel*firstLable=[[UILabel alloc]init];
    [cell addSubview:firstLable];
    UILabel*secondLable=[[UILabel alloc]init];
    [cell addSubview:secondLable];
    firstLable.numberOfLines=2;
    firstLable.text=model.companyName;
    firstLable.font=[UIFont boldSystemFontOfSize:17];
     firstLable.frame=CGRectMake(15, 10, KWIDTH-30, firstLable.height);
    [firstLable sizeToFit];
    secondLable.text=model.name;
    secondLable.font=[UIFont systemFontOfSize:14];
    secondLable.frame=CGRectMake(15, CGRectGetMaxY(firstLable.frame)+5, KWIDTH-30, secondLable.height);
    [secondLable sizeToFit];
   cell.frame=CGRectMake(0, 0, KWIDTH, CGRectGetMaxY(secondLable.frame)+10);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate  PickerViewOneDelegateOncleck:indexPath];
    [self leftbtnOnclick];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)leftbtnOnclick{
    [self close];
}

- (void)rightBtnOnclick{
    
   
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
