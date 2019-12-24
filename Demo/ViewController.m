//
//  ViewController.m
//  Demo
//
//  Created by 党玉华 on 2019/12/21.
//  Copyright © 2019 Linkdom. All rights reserved.
//

#import "ViewController.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "WebHandleVC.h"
#import "KeplerApiManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点击屏幕空白处选择跳转类型";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"京东商品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self JDAction:@"https://item.jd.com/61731900259.html#crumb-wrap"];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"京东店铺" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self JDAction:@"https://mall.jd.com/index-35345.html"];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"淘宝商品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self TaobaoOrTmallAction:@"https://item.taobao.com/item.htm?id=562764722244&ali_refid=a3_430585_1006:1150880585:N:DUg%2Bj3CMzmlOAscDHHaGaQ%3D%3D:ad3b2c4faed88ccfa8aff8e6c1614e37&ali_trackid=1_ad3b2c4faed88ccfa8aff8e6c1614e37&spm=a230r.1.14.6#detail"];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"淘宝店铺" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self TaobaoOrTmallAction:@"https://shop423979369.taobao.com/?spm=2013.1.0.0.5e81410es8jnuQ"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)TaobaoOrTmallAction:(NSString *)url{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]]){
        AlibcWebViewController *vc = [[AlibcWebViewController alloc] init];
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeNative;
        showParam.isNeedPush=YES;
        showParam.nativeFailMode=AlibcNativeFailModeJumpH5;
        NSInteger ret =[[AlibcTradeSDK sharedInstance].tradeService openByUrl:url identity:@"trade" webView:vc.webView parentController:vc showParams:showParam taoKeParams:nil trackParam:nil tradeProcessSuccessCallback:nil tradeProcessFailedCallback:nil];
        NSLog(@"%zd",ret);
    }else{
        [self webviewAction:url];
    }
}
-(void)JDAction:(NSString *)url{
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"openapp.jdmobile://"]]){
        [[KeplerApiManager sharedKPService]openKeplerPageWithURL:url userInfo:nil failedCallback:^(NSInteger code, NSString *url) {
            NSLog(@"%zd-%@",code,url);
        }];
    }else{
        [self webviewAction:url];
    }
}
-(void)webviewAction:(NSString *)url{
    WebHandleVC *vc = [[WebHandleVC alloc]init];
    vc.url =  url;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
