//
//  YXPreviewManage.h
//  BusinessFine
//
//  Created by 杨旭 on 2019/10/21.
//  Copyright © 2019年 杨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SJVideoPlayer;
@interface DDPreviewManage : NSObject

+ (DDPreviewManage *)sharePreviewManage;


// 预览视频
- (void)showVideoWithUrl:(NSString *)url withController:(UIViewController *)controller;

// 预览党建列表视频
- (void)showVideoListWithUrl:(NSString *)url
              collectionView:(UICollectionView *)collectionView
                   IndexPath:(NSIndexPath *)indexPath
                      player:(SJVideoPlayer *)player;

// 预览图片
- (void)showPhotoWithImgArr:(NSArray *)imgArr imgTitleArr:(NSArray *)imgTitleArr currentIndex:(NSInteger)currentIndex;



@end

NS_ASSUME_NONNULL_END
