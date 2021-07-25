//
//  DDStarReportCollectionViewCell.m
//  ZWHelp
//
//  Created by 杨旭 on 2021/1/30.
//  Copyright © 2021 杨旭. All rights reserved.
//

#define Chart_Colors  @[@"#4893ED",@"#25BA11",@"#F65E5E",@"#FBCF00",@"#B300BE",@"#e4007f",@"#8c97cb",@"#b28850"]

#import "DDStarReportCollectionViewCell.h"
#import <AAChartKit.h>
#import "DDStarModel.h"
@interface DDStarReportCollectionViewCell ()<AAChartViewEventDelegate>

@property (nonatomic ,strong) UIView *backView;
@property (nonatomic, strong) AAChartModel *chartModel;
@property (nonatomic, strong) AAChartView  *chartView;
@property (nonatomic, strong) AAOptions  *chartOptions;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation DDStarReportCollectionViewCell

- (void)setExtendArr:(NSArray *)extendArr {
    _extendArr = extendArr;
    
    if (_extendArr.count) {
        self.dataArr = [NSMutableArray array];
        for (DDExtendModel *extendModel in _extendArr) {
            NSMutableArray *tempArr = [NSMutableArray array];
            [tempArr addObject:[NSString stringWithFormat:@"%@星:%ld家",extendModel.grade,extendModel.num]];
            [tempArr addObject:@(extendModel.num)];
            [self.dataArr addObject:tempArr];
         }
        [self configChartOptions];
    
    }
 
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color_BackColor;
        [self setUpLayout];
    }
    return self;
}

/// 配置图标参数
- (void)configChartOptions{

    self.chartModel = AAChartModel.new
    .animationDurationSet(@1500)
    .chartTypeSet(AAChartTypePie);
    AASeriesElement *element = AASeriesElement.new
    .nameSet(@"家")
    .innerSizeSet(@"60%")//内部圆环半径大小占比
    .borderWidthSet(@0)//描边的宽度
    .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
    .dataSet(self.dataArr);
    self.chartModel.seriesSet(@[element]);
    [self.chartView aa_drawChartWithChartModel:self.chartModel];
}


- (void)setUpLayout {
    
    DDWeakSelf
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.chartView];

    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.backView);
     }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 12.0f;
    }
    return _backView;
}

- (AAChartView *)chartView{
    if (!_chartView) {
        _chartView = [[AAChartView alloc]init];
        _chartView.scrollEnabled = NO;
        _chartView.scrollView.showsVerticalScrollIndicator = NO;
        _chartView.scrollView.showsHorizontalScrollIndicator = NO;
        
        //获取图表加载完成事件
        [_chartView didFinishLoadHandler:^(AAChartView *aaChartView) {
            NSLog(@"🚀🚀🚀🚀 AAChartView content did finish load!!!");
        }];
        
        //获取图表上的手指点击及滑动事件
        [_chartView moveOverEventHandler:^(AAChartView *aaChartView,
                                           AAMoveOverEventMessageModel *message) {
            //            NSDictionary *messageDic = @{
            //                @"category":message.category,
            //                @"index":@(message.index),
            //                @"name":message.name,
            //                @"offset":message.offset,
            //                @"x":message.x,
            //                @"y":message.y
            //            };
            //
            //            NSString *str1 = [NSString stringWithFormat:@"👌👌👌👌 selected point series element name: %@\n",
            //                              message.name];
            //            NSString *str2 = [NSString stringWithFormat:@"user finger moved over!!!,get the move over event message: %@",
            //                              messageDic];
            //            NSLog(@"%@%@",str1, str2);
        }];
    }
    return _chartView;
}



@end
