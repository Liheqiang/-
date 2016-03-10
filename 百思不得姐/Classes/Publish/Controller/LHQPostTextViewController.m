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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:nil highlightedImage:nil target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil highlightedImage:nil target:self action:@selector(post)];
}

- (void)setupTextView{
    LHQPlaceholderTextView *textView = [[LHQPlaceholderTextView alloc] init];
    textView.placeholder = @"";
}

#pragma -
#pragma mark -
- (void)cancle{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{
    
}
@end
