//
//  LHQPostTextViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/10.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQPostTextViewController.h"
#import "LHQNavigationController.h"
#import "LHQPlaceholderTextView.h"

@interface LHQPostTextViewController ()
@property (nonatomic, strong) LHQPlaceholderTextView *textView;
@end

@implementation LHQPostTextViewController
#pragma -
#pragma mark - life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupTextView];
}

- (void)setupNavi{
    
    self.title = @"发布文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupTextView{
    LHQPlaceholderTextView *textView = [[LHQPlaceholderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.font = [UIFont systemFontOfSize:13];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
}

#pragma -
#pragma mark -
- (void)cancle{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{
    
}
@end
