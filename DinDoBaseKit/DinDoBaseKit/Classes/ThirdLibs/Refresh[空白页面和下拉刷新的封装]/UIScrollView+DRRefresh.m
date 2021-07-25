//
//  UIScrollView+DRRefresh.m
//  EmptyDataRefreshDemo
//
//  Created by chenzhen on 2017/4/7.
//  Copyright © 2017年 幽灵鲨. All rights reserved.
//

#import "UIScrollView+DRRefresh.h"
#import "MJRefresh.h"

@implementation UIScrollView (DRRefresh)


- (void)setRefreshWithHeaderBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock{

    
    if (headerBlock) {
        
        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (headerBlock) {
                headerBlock();
            }
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
    }
    if (footerBlock) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        [footer setTitle:@"我是有底线的" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden = YES;
        self.mj_footer = footer;
    }
    
}

- (void)headerBeginRefreshing
{
    [self.mj_header beginRefreshing];
}

- (void)headerEndRefreshing
{
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing
{
    [self.mj_footer endRefreshing];
}

- (void)footerNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)hideFooterRefresh{
    self.mj_footer.hidden = YES;
}


- (void)hideHeaderRefresh{
    self.mj_header.hidden = YES;
}
- (void)openFooterRefresh{
    self.mj_footer.hidden = NO;
}

- (void)openHeaderRefresh{
    self.mj_header.hidden = NO;
}


@end
