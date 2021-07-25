//
//  DDWebViewModel.m
//  ZWHelp
//
//  Created by 杨旭 on 2020/6/4.
//  Copyright © 2020 杨旭. All rights reserved.
//

#import "DDWebViewModel.h"
#import "DDWebViewController.h"
#import "DDScanViewController.h"
#import "WatermarkCameraController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <UIBarButtonItem+Extensions.h>
#import "DDWebBLL.h"
#import "DDWebManager.h"
#import "DDPreviewManage.h"
#import "UIViewController+JNetWork.h"
@interface DDWebViewModel ()<WKNavigationDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) UIBarButtonItem *leftItem;

@property (strong, nonatomic) UIBarButtonItem *rightItem;

@property (weak, nonatomic) UIViewController *viewCotroller;

@property (weak, nonatomic)  WKWebView *webView;

@property (strong, nonatomic)  WKWebViewJavascriptBridge* bridge;

@property (strong, nonatomic) NSDictionary *dataDic;

@property (strong, nonatomic) UIDocumentInteractionController *doc;

@property (strong, nonatomic) NSString *adderss;

@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSString *searchUrl;

@end

@implementation DDWebViewModel

- (void)setViewCotroller:(UIViewController *)viewCotroller {
    _viewCotroller = viewCotroller;
}

- (void)setAddress:(NSString *)address {
    _adderss = address;
}

- (void)setWebView:(WKWebView*)webView bridge:(WKWebViewJavascriptBridge *)bridge{
    _webView = webView;
    _bridge = bridge;
    [self JS2OC];
}

- (void)setCreateLeftItemWithUrl:(NSString *)url {
    
    // 判断通讯录加载详情页时添加返回按钮
    if ([url containsString:DD_Contacts_PhoneBook]) {
//        _viewCotroller.navigationItem.leftBarButtonItem = nil;
        _leftItem = [UIBarButtonItem initLeftItems:_webView.title imageStr:@"" target:self action:@selector(leftItemAction)];
        _viewCotroller.navigationItem.leftBarButtonItem = _leftItem;
        
    }else {
//        _leftItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back_black"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftItemAction)];
//        _viewCotroller.navigationItem.leftBarButtonItem = _leftItem;

        _leftItem = [UIBarButtonItem initLeftItems:_webView.title imageStr:@"navi_back_black" target:self action:@selector(leftItemAction)];
        _viewCotroller.navigationItem.leftBarButtonItem = _leftItem;
        
    }
    
}

- (void)setCreateRightItemWithUrl:(NSString *)url SearchTitle:(NSString *)searchTitle searchUrl:(NSString *)searchUrl {
    _url = url;
    _searchUrl = searchUrl;
    // 判断加载是否有搜索标题
    if (searchTitle.length > 0) {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:searchTitle style:(UIBarButtonItemStyleDone) target:self action:@selector(rightItemAction)];
        _rightItem.tintColor = color_TextOne;
        _viewCotroller.navigationItem.rightBarButtonItem = _rightItem;
    }else if ([_url containsString:DD_Affairs_HandlingFeedback]||
              [_url containsString:DD_Party_ThreeLessons]) { // 判断是否是上报记录页面或者是三会一课页面
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightItemAction)];
        _rightItem.tintColor = color_TextOne;
        _viewCotroller.navigationItem.rightBarButtonItem = _rightItem;
    }else if ([_url containsString:DD_ZFRZ]) { // 判断是否是走访日志页面
        _rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_scan"] style:(UIBarButtonItemStyleDone) target:self action:@selector(scanClick)];
        _viewCotroller.navigationItem.rightBarButtonItem = _rightItem;
    }else {
        _viewCotroller.navigationItem.rightBarButtonItem = nil;
    }
    
}

- (void)leftItemAction {
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [_viewCotroller.navigationController popViewControllerAnimated:YES];
    }
   
}

- (void)rightItemAction {
    
    if (_searchUrl.length > 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,_searchUrl];
        NSString *url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        DDWebViewController *webVC = [[DDWebViewController alloc] init];
        webVC.url = url;
        [_viewCotroller.navigationController pushViewController:webVC animated:YES];
    }else if ([_url containsString:DD_Affairs_HandlingFeedback]||
              [_url containsString:DD_Party_ThreeLessons]) { // 判断是否是上报记录页面或者是三会一课页面
        [self getOCToJsMethods:@"opensearch" param:nil];
    }

}

- (void)scanClick {
    
    DDWeakSelf
    DDScanViewController *scanVC = [DDScanViewController new];
    scanVC.type = 1;
    scanVC.scanSuccessReslut = ^(NSString * _Nonnull reslut) {
        [weakSelf getOCToJsMethods:@"scanResults" param:reslut];
    };
    scanVC.modalPresentationStyle = UIModalPresentationFullScreen;
    DDBaseNavigationController *nav = [[DDBaseNavigationController alloc]initWithRootViewController:scanVC];
    [_viewCotroller presentViewController:nav animated:YES completion:nil];

}


#pragma mark - JS调用OC
- (void)JS2OC{
    
    YXWeakSelf
    // 选择图片上传照片
    [_bridge registerHandler:@"photoSelectAlbumAndPhotograph" handler:^(id data, WVJBResponseCallback responseCallback) {
          NSLog(@"JS调用OC，并传值过来 %@",data);
          // 利用data参数处理自己的逻辑
        NSInteger num = [data[@"num"] integerValue];
        if (num == 0) {
            KPOP(@"已选择最大数量图片");
        }else{
            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:num
                                                                                                  delegate:self];
            [imagePicker setSortAscendingByModificationDate:NO];
            imagePicker.isSelectOriginalPhoto = YES;
            imagePicker.allowPickingVideo = NO;
            imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        }
      }];
    
    // 拍照上传照片
    [_bridge registerHandler:@"wgbCommonUploadImg" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来 %@",data);
        weakSelf.dataDic = data;
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            WatermarkCameraController *controller = [[WatermarkCameraController alloc] init];
            controller.userName = [DDUserInfoManager getUserInfo].userName;
            controller.address = weakSelf.adderss?weakSelf.adderss:@"";
            controller.shot = ^(UIImage *image) {
                [weakSelf upLoadImage:image];
            };
            controller.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }];
    
    // 下载文件
    [_bridge registerHandler:@"iosdown" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *filepath = data[@"filepath"];
        if (filepath.length > 0) {
            if ([filepath hasPrefix:@"http"]) {
                if ([filepath hasSuffix:@"zip"] || [filepath hasSuffix:@"rar"]) {
                    [weakSelf downFileWithFileLink:filepath];
                }else {
                    NSMutableArray*images = [NSMutableArray array];
                    [images addObject:filepath];
                    [[DDPreviewManage sharePreviewManage] showPhotoWithImgArr:images imgTitleArr:@[] currentIndex:0];
                }
            }
        }

    }];
    
    // 上传地理位置
    [_bridge registerHandler:@"returnAddress" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (weakSelf.adderss) {
            NSString *location = weakSelf.adderss?weakSelf.adderss:@"";
            [weakSelf getOCToJsMethods:@"wgbUpLoadAddress" param:location];
        }else {
            [[DDWebManager sharedWebManager] userLocationSuccess:^(NSString * _Nonnull address) {
                weakSelf.adderss = address;
                [weakSelf getOCToJsMethods:@"wgbUpLoadAddress" param:address];
            }];
        }
    }];
    
    
    // 隐藏导航栏
    [_bridge registerHandler:@"isTophidden" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf.viewCotroller.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [weakSelf.viewCotroller.navigationController setNavigationBarHidden:YES animated:NO];
    }];
    
    // 返回上一页面
    [_bridge registerHandler:@"goBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([weakSelf.webView canGoBack]) {
            [weakSelf.webView goBack];
        }else{
            [weakSelf.viewCotroller.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    // 拨打电话
    [_bridge registerHandler:@"callPhone" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *phoneS  =  data[@"phone"];
        if (phoneS.length>0) {
            NSString *num  =  [[NSString alloc] initWithFormat:@"telprompt://%@",phoneS];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }else{
            [YJProgressHUD showMessage:@"暂无联系方式！"];
        }
    }];
    
    // 页面旋转
    [_bridge registerHandler:@"webSetRequestedOrientation" handler:^(id data, WVJBResponseCallback responseCallback) {
        weakSelf.dataDic = data;
        if (weakSelf.dataDic.count) {
            NSInteger across = [weakSelf.dataDic[@"across"] integerValue];
            if ( across == 1) {
                [weakSelf.viewCotroller setNewOrientation:YES];
            }else {
                [weakSelf.viewCotroller setNewOrientation:NO];
            }
        }
    }];
    
    
}


#pragma mark - OC调JS方法
/**
@param methods  JS方法名
@param param    传入参数
*/
- (void)getOCToJsMethods:(NSString *)methods param:(NSString *)param {
    
    NSString *jsStr = [NSString stringWithFormat:@"%@('%@')",methods,param];
    NSLog(@"jsStr == %@",jsStr);
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"上传成功");
        }else {
            NSLog(@"上传失败");
        }
    }];
}

#pragma mark - TZImagePickerController Delegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    if (photos.count > 0) {
        [self selectUpLoadImageArr:photos];
    }
}


#pragma mark - 选择图片上传照片
- (void)selectUpLoadImageArr:(NSArray *)imageArr {
    
    YXWeakSelf
    [YJProgressHUD showLoading:@"正在上传中..."];
    [[DDWebBLL sharedWebBLL] uploadImgWithImageArr:imageArr Success:^(id  _Nonnull responseObject) {
        [YJProgressHUD hideHUD];
        NSArray *imageIds = responseObject[@"data"];
        if (imageIds.count > 0) {
            for (NSString *imageId in imageIds) {
                [weakSelf getOCToJsMethods:@"onUploadImgIDs" param:imageId];
            }
        }
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
    
}


#pragma mark - 拍照上传照片
- (void)upLoadImage:(UIImage *)image {
    
    YXWeakSelf
    [YJProgressHUD showLoading:@"正在上传中..."];
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    if (self.dataDic) {
        [parDic setValue:self.dataDic[@"moduleId"] forKey:@"moduleId"];
        [parDic setValue:self.dataDic[@"moduleSign"] forKey:@"moduleSign"];
        [parDic setValue:self.dataDic[@"pageName"] forKey:@"pageName"];
        [parDic setValue:self.dataDic[@"tableId"] forKey:@"tableId"];
        [parDic setValue:self.adderss forKey:@"remark"];
    }
    [[DDWebBLL sharedWebBLL] uploadImgWithFiles:image ParDic:parDic Success:^(id  _Nonnull responseObject) {
        [YJProgressHUD hideHUD];
        NSDictionary *dataDic = responseObject[@"data"];
        if (dataDic) {
            NSString  *imgId = [NSString stringWithFormat:@"%@",dataDic[@"imgId"]];
            [weakSelf getOCToJsMethods:@"wgbCommenUpLoadImageBack" param:imgId];
        }
    } bllFailed:^(NSString * _Nonnull msg) {
        [YJProgressHUD showMessage:msg];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [YJProgressHUD hideHUD];
    } onRequestTimeOut:^{
        [YJProgressHUD hideHUD];
    }];
    
}

#pragma mark - 点击下载文件
- (void)downFileWithFileLink:(NSString *)fileLink {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths lastObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileLink];
    if ([fileManager fileExistsAtPath:filePath]) {
        // 文件已经存在，直接打开
        [self openDocxWithPath:filePath];
    }else {
        // 文件不存在，要下载
        [self downloadDocxWithDocPath:documentDirectory fileName:fileLink];
        
    }
}

#pragma mark - 下载文件
- (void)downloadDocxWithDocPath:(NSString *)docPath fileName:(NSString *)fileName {
    
    [YJProgressHUD showLoading:@"正在下载"];
    NSURL *url = [NSURL URLWithString:[fileName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *path = [docPath stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [YJProgressHUD hideHUD];
        NSString *name = [filePath path];
        [self openDocxWithPath:name];
    }];

    [task resume];
}


#pragma mark - 预览打开文件
- (void)openDocxWithPath:(NSString *)filePath {
    
    NSLog(@"预览文件路径：%@",filePath);
    filePath = [NSString stringWithFormat:@"file://%@",filePath];
    self.doc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    self.doc.delegate = self;
    [self.doc presentOpenInMenuFromRect:self.viewCotroller.view.bounds inView:self.viewCotroller.view animated:YES];

//    [doc presentPreviewAnimated:YES];
}


@end
