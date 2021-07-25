//
//  WatermarkCameraController.h
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/2.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatermarkCameraOverlayView.h"

@interface WatermarkCameraController : UIImagePickerController

/** 是否需要12小时制处理，default is NO */
@property (nonatomic, assign) BOOL isTwelveHandle;
@property (nonatomic,  copy ) NSString *userName;
@property (nonatomic,  copy ) NSString *address;
/**拍摄后获取到带水印的照片*/
@property (nonatomic,  copy ) void(^shot)(UIImage *image);

@end
