//
//  DDWebBLL.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/5/23.
//

#import "DDWebBLL.h"
#import "UIImage+ColorImage.h"

@implementation DDWebBLL

+ (DDWebBLL *)sharedWebBLL {
    static DDWebBLL *webBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        webBLL = [[self alloc] init];
    });
    
    return webBLL;
}


- (void)uploadImgWithFiles:(UIImage *)files
                    ParDic:(NSDictionary *)parDic
                   Success:(onUploadImgSuccess)success
                 bllFailed:(bllFailed)bllFailed
             onNetWorkFail:(onNetWorkFail)onNetWorkFail
          onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_5/mobile/common/uploadImg.do"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithDictionary:parDic];;

    NSData *imageData = [files compressWithMaxLength:1024 * 1024 * 15];
    
    [dataDic setValue:imageData forKey:@"files"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //上传的参数名
    NSString *name = [NSString stringWithFormat:@"%@%d", [NSDate date], arc4random() % 100];
    NSString *fileName = [NSString stringWithFormat:@"%@.jepg", name];
    
    [self uploadWithapiUrl:urlStr version:1 imageArr:@[files] nameArr:@[@"files"] fileNameArr:@[fileName] parDic:dataDic uploadSuccess:^(id  _Nonnull responseObject) {
        [self analyseResult:responseObject bllSuccess:^{
            success(responseObject);
        } bllFailed:^(NSString * _Nonnull msg) {
            bllFailed(msg);
        } isShow:NO];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        onNetWorkFail(msg);
    } onRequestTimeOut:^{
        onRequestTimeOut();
    }];
    
}


- (void)uploadImgWithImageArr:(NSArray *)imageArr
                      Success:(onUploadImgSuccess)success
                    bllFailed:(bllFailed)bllFailed
                onNetWorkFail:(onNetWorkFail)onNetWorkFail
             onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",kBaseUrl,@"1_4/service/app/center/uploadImg.do"];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:@"" forKey:@"tableId"];

    NSMutableArray *nameArr = [NSMutableArray array];
    NSMutableArray *fileNameArr = [NSMutableArray array];
    for (NSInteger i=0; i<imageArr.count; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";        //设置日期格式
        NSString *nameNum = [NSString stringWithFormat:@"%@%d", [NSDate date], arc4random() % 100];
        NSString *fileName = [NSString stringWithFormat:@"%@.jepg", nameNum];  //上传文件名字fileName
        NSString *name = @"files"; //上传的参数名
        [nameArr addObject:name];
        [fileNameArr addObject:fileName];
    }
    [self uploadWithapiUrl:urlStr version:1 imageArr:imageArr nameArr:nameArr fileNameArr:fileNameArr parDic:dataDic uploadSuccess:^(id  _Nonnull responseObject) {
           [self analyseResult:responseObject bllSuccess:^{
               success(responseObject);
           } bllFailed:^(NSString * _Nonnull msg) {
               bllFailed(msg);
           } isShow:NO];
       } onNetWorkFail:^(NSString * _Nonnull msg) {
           onNetWorkFail(msg);
       } onRequestTimeOut:^{
           onRequestTimeOut();
       }];
    
}



@end
