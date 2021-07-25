//
//  DDDeviceUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DDDeviceUtils.h"
#import <Photos/Photos.h>

@implementation DDDeviceUtils

+ (DDDeviceUtils *)sharedDDDeviceUtils
{
    
    static DDDeviceUtils *ddDeviceUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddDeviceUtils = [[DDDeviceUtils alloc] init];
        
    });
    
    return ddDeviceUtils;
}

- (NSString *)app_Version{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

- (void)userCamera:(onCameraUsable)onCameraUsable{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        // 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"访问相机失败" message:@"请打开 设置-隐私-相机 来进行设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            // 这里是摄像头可以使用的处理逻辑
            onCameraUsable();
        }
    } else {
        
        NSLog(@"硬件问题提示");
    }
}


- (void)userAlbum:(onAlbumUsable)onAlbumUsable {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        if (status == PHAuthorizationStatusAuthorized) {
            // 这里是摄像头可以使用的处理逻辑
            onAlbumUsable();
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"访问相册失败"
                                                            message:@"请打开 设置-隐私-照片 来进行设置"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    
    
}


@end
