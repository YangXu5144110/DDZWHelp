//
//  YXPreviewManage.m
//  BusinessFine
//
//  Created by 杨旭 on 2019/10/21.
//  Copyright © 2019年 杨旭. All rights reserved.
//

#import "DDPreviewManage.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <YBImageBrowser.h>
#import <YBIBVideoData.h>
#import <SJVideoPlayer/SJVideoPlayer.h>

@interface DDPreviewManage ()<YBImageBrowserDelegate>
@property (nonatomic ,strong) NSMutableArray *photos;
@property (nonatomic ,strong) NSArray *imgTitleArr;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic, strong) SJVideoPlayer *player;
@end

@implementation DDPreviewManage

+ (DDPreviewManage *)sharePreviewManage{
    static DDPreviewManage *previewManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        previewManager = [[self alloc]init];
    });
    return previewManager;
}


- (void)showVideoWithUrl:(NSString *)url withController:(UIViewController *)controller {
    
    if (url.length > 0) {
        YBIBVideoData *data = [YBIBVideoData new];
        data.videoURL = [NSURL URLWithString:url];
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.toolViewHandlers = nil;
        browser.dataSourceArray = @[data];
        browser.currentPage = 0;
        browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
        [browser show];
    }
}


- (void)showVideoListWithUrl:(NSString *)url
              collectionView:(UICollectionView *)collectionView
                   IndexPath:(NSIndexPath *)indexPath
                      player:(SJVideoPlayer *)player {
     if (url.length > 0) {
         self.player = player;
         SJPlayModel *playModel = [SJPlayModel playModelWithCollectionView:collectionView indexPath:indexPath];
         SJVideoPlayerURLAsset *asset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:url] playModel:playModel];
         self.player.URLAsset = asset;
     }
    
}


- (void)showPhotoWithImgArr:(NSArray *)imgArr imgTitleArr:(NSArray *)imgTitleArr currentIndex:(NSInteger)currentIndex{
    
    _photos = [NSMutableArray array];
    _imgTitleArr = imgTitleArr;
    for (id tem in imgArr) {
        if ([tem isKindOfClass:[UIImage class]]){
            YBIBImageData *data = [YBIBImageData new];
            data.image = ^UIImage * _Nullable{
                return tem;
            };
            [_photos addObject:data];
              
        }else if ([tem isKindOfClass:[NSString class]]) {
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:tem];
            [_photos addObject:data];
        }
    }


    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = _photos;
    browser.currentPage = currentIndex;
    browser.delegate = self;
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser addSubview:self.titleLab];
    [browser show];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        if (@available(iOS 11.0,*)) {
            make.bottom.mas_equalTo(browser.mas_safeAreaLayoutGuideBottom).offset(-50);
        }else{
            make.bottom.mas_equalTo(-50);
        }
        [_titleLab sizeToFit];
    }];
    

}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:14.0];
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

#pragma mark - YBImageBrowserDelegate
- (void)yb_imageBrowser:(YBImageBrowser *)imageBrowser pageChanged:(NSInteger)page data:(id<YBIBDataProtocol>)data {
    if (_imgTitleArr.count > 0) {
        _titleLab.text = _imgTitleArr[page];
    }
}
@end
