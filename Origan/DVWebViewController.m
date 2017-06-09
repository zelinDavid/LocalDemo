//
//  DVWebView.m
//  Origan
//
//  Created by David on 17/5/4.
//  Copyright © 2017年 David. All rights reserved.
//

#import "DVWebViewController.h"
#import <WebKit/WebKit.h>
@interface DVWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic, strong)  WKWebView *webView;
@property(nonatomic, copy) NSString *urlStr;
@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) NSRecursiveLock *mylock;

@end

@implementation DVWebViewController

-(instancetype)initWithUrlString:(NSString *)urlStr  {
    if (self = [super init]) {
        _urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    [self initProgressView];

 }

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];

}
-(void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark -UIdelegate 
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completionHandler) {
            completionHandler();
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - navigationDelegate 
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
     decisionHandler(WKNavigationActionPolicyAllow);
    
    
    
}



#pragma mark - KVO


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"context---%f",[[change objectForKey:NSKeyValueChangeNewKey] floatValue]);
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (![NSThread isMainThread]) {
            [self performSelectorOnMainThread:@selector(updateProgress:) withObject:object waitUntilDone:NO];
        } else {
            [self updateProgress:object ];
        }
        
    }
}

-(void)updateProgress:(id)object {
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:100];
    WKWebView *temWebView = (WKWebView *)object;
    progress.completedUnitCount = temWebView.estimatedProgress *100;
    
    CGFloat currentProgress = progress.completedUnitCount / (CGFloat)progress.totalUnitCount;
    
    NSLog(@"currentProgress---%f",currentProgress);
    if (currentProgress >= 1.0) {
        [_progressView setProgress:1 animated:YES ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _progressView.alpha = 0;
            _progressView.progress = 0;
        });
    }
    else {
        _progressView.alpha = 1;
        [_progressView setProgress:currentProgress animated:YES];
 
    }
}


-(void)initWebView {
    WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
    configuretion.preferences = [[WKPreferences alloc]init];
    configuretion.preferences.minimumFontSize = 10;
    configuretion.processPool = [[WKProcessPool alloc]init];
    // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
    configuretion.preferences.javaScriptCanOpenWindowsAutomatically = YES;

    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuretion];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    _webView.backgroundColor = [UIColor yellowColor];
    
}

-(void)initProgressView {
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, 2)];
    _progressView.progressTintColor = [UIColor blackColor];
    
    [self.view addSubview:_progressView];
}





@end
