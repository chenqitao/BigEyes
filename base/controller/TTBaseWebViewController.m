//
//  TTBaseWebViewController.m
//  招标
//
//  Created by mac chen on 15/7/21.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTBaseWebViewController.h"

@interface TTBaseWebViewController ()
{
    
    UIWebView *webView;
}

@end

@implementation TTBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

-(void)createUI{
    webView = [UIWebView new];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    NSURL* url = [NSURL URLWithString:_mainUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
}

@end
