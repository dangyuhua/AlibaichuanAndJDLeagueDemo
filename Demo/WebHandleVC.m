//
//  WebHandleVC.m
//  Demo
//
//  Created by 党玉华 on 2019/12/23.
//  Copyright © 2019 Linkdom. All rights reserved.
//

#import "WebHandleVC.h"
#import <WebKit/WebKit.h>

@interface WebHandleVC ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong)WKWebView *webview;

@end

@implementation WebHandleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI{
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:WKWebViewConfiguration.new];
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate = self;
    self.webview.allowsBackForwardNavigationGestures = YES;
    if (UIDevice.currentDevice.systemVersion.floatValue >= 9.0) {
        if (@available(iOS 9.0, *)) {
            self.webview.allowsLinkPreview = NO;
        } else {
            
        }
    }
    self.webview.scrollView.bounces = NO;
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//结束
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}
//开始
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

@end
