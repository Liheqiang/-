//
//  LHQTopWindowViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/7.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTopWindowViewController.h"

@interface LHQTopWindowViewController ()

@end

@implementation LHQTopWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSArray *windows = [UIApplication sharedApplication].windows;

    for (UIWindow *window in windows) {
        [self searchScrollViewInView:window];//查找子视图中的scrollView
    }
}
/**
 * 搜索superview内部的所有子控件
 */
- (void)searchScrollViewInView:(UIView *)superView{
    
    for (UITableView *tableView in superView.subviews) {
        
        [self searchScrollViewInView:tableView];
        
        if (![tableView isKindOfClass:[UIScrollView class]])continue;
        if (!tableView.isShowingOnKeyWindow) continue;
            CGPoint offset = tableView.contentOffset;
            offset.y = -tableView.contentInset.top;
            [tableView setContentOffset:offset animated:YES];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{//不实现这个，系统自带的状态栏就没了
    return NO;
}
@end
