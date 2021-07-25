//
//  DDWebViewController.m
//  DinDoBaseKit_Example
//
//  Created by 杨旭 on 2020/5/19.
//  Copyright © 2020 wg. All rights reserved.
//

#import "DDWebViewController.h"
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>
#import "LMWebProgressLayer.h"
#import "DDWebManager.h"
#import "DDWebViewModel.h"
#import "UIViewController+RotationControl.h"
static void *KINWebBrowserContext = &KINWebBrowserContext;
@interface DDWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic)  WKWebView *webView;
@property (strong, nonatomic)  LMWebProgressLayer *progressLayer; ///< 网页加载进度条
@property (strong, nonatomic)  WKWebViewJavascriptBridge* bridge;
@property (strong, nonatomic)  DDWebViewModel *viewModel;

@end

@implementation DDWebViewController


-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self finishedLoad];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
    [[DDWebManager sharedWebManager] clearCache];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
//        self.title= self.webView.title;
        if ([self.webView canGoBack]) {
            self.navigationItem.rightBarButtonItem=nil;
        }else{
        }
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            } completion:^(BOOL finished) {
            }];
        }
    } else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView)
        {
//            self.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=self.titleStr;

    // 定位
    DDWeakSelf
    [[DDWebManager sharedWebManager] userLocationSuccess:^(NSString * _Nonnull address) {
        NSLog(@"地址：%@",address);
        [weakSelf.viewModel setAddress:address];
    }];
    
    // 添加子视图
    [self loadSubViews];
    [self.viewModel setViewCotroller:self];
    [self.viewModel setWebView:self.webView bridge:self.bridge];
    
    
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:KINWebBrowserContext];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    // 判断传入的url是否有值
    if (_url.length > 0) { //加载点击模块对应的页面
        _url = [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }else { // 加载通讯录页面
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *link = [NSString stringWithFormat:@"%@%@",kBaseUrl,DD_Contacts_PhoneBook];
        [dic setValue:DD_Contacts_PhoneBook forKey:@"meshingId"];
        _url = [[DDWebManager sharedWebManager] getLinkUrlStringWithLink:link Param:dic];
        _url = [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
    
}

- (void)loadSubViews {
    
    self.webView = [WKWebView new];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    [self.view.layer addSublayer:self.progressLayer];
    YXWeakSelf
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(weakSelf.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(weakSelf.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.edges.mas_equalTo(weakSelf.view);
        }
    }];
}


#pragma mark - WKWebView Delegate
-(void)webView:(WKWebView*)webView didStartProvisionalNavigation:(WKNavigation*)navigation{
    [_progressLayer startLoad];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self finishedLoad];
}
-(void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation{
    [self finishedLoad];
    [self.viewModel setCreateLeftItemWithUrl:webView.URL.absoluteString];
    [self.viewModel setCreateRightItemWithUrl:webView.URL.absoluteString SearchTitle:self.searchTitle searchUrl:self.searchUrl];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self finishedLoad];
    [self.viewModel setCreateLeftItemWithUrl:webView.URL.absoluteString];
    [self.viewModel setCreateRightItemWithUrl:webView.URL.absoluteString SearchTitle:self.searchTitle searchUrl:self.searchUrl];
    
}

- (void)finishedLoad {
    [_progressLayer finishedLoad];
    _progressLayer = nil;
    [_progressLayer closeTimer];
}
- (void)setUrl:(NSString *)url {
    _url = url;
}

#pragma mark - Lazy loading
- (LMWebProgressLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [LMWebProgressLayer new];
        _progressLayer.frame = CGRectMake(0, 0, KWIDTH, 1.5);
    }
    return _progressLayer;
}

- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        [WKWebViewJavascriptBridge enableLogging];
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

- (DDWebViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [DDWebViewModel new];
    }
    return _viewModel;
}
- (BOOL)shouldAutorotate
{
    return NO;
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
