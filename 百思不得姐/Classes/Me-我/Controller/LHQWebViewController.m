//
//  LHQWebViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/9.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQWebViewController.h"

@interface LHQWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LHQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
- (IBAction)goBack:(id)sender {
   
    [self.webView goBack];
    
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

#pragma -
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goBackButton.enabled = webView.canGoBack;
    self.goForwardButton.enabled = webView.canGoForward;
    
}

@end
