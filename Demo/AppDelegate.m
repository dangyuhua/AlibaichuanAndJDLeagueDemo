//
//  AppDelegate.m
//  Demo
//
//  Created by 党玉华 on 2019/12/21.
//  Copyright © 2019 Linkdom. All rights reserved.
//

#import "AppDelegate.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "KeplerApiManager.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 缺少一张淘宝安全图
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupAlibcService];
    [self setupJDService];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:ViewController.new];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}
//阿里百川初始化
-(void)setupAlibcService{
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
     [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        NSLog(@"初始化成功");
    } failure:^(NSError *error) {
        NSLog(@"初始化失败");
    }];
    #if defined (DEBUG)||defined(_DEBUG)
    // 开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];
    #endif
}
//京东初始化
-(void)setupJDService{
    [[KeplerApiManager sharedKPService]asyncInitSdk:@"appKey" secretKey:@"secretKey" sucessCallback:^{
        NSLog(@"注册成功");
    } failedCallback:^(NSError *error) {
        NSLog(@"注册失败");
    }];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        //处理其他app跳转到自己的app，如果百川处理过会返回YES
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if (@available(iOS 9.0, *)) {
        if (![[AlibcTradeSDK sharedInstance] application:application openURL:url options:options]) {
            //处理其他app跳转到自己的app，如果百川处理过会返回YES
            
        }
    }
    return YES;
}


@end
