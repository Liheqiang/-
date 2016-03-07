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
        
        UIWindow *window = tableView.window;
        //将本身转换到另一个坐标系
        CGRect newFrame = [tableView convertRect:tableView.bounds toView:window];
        CGRect windowBounds = window.bounds;
        
        BOOL isIntersectsRect = CGRectIntersectsRect(newFrame, windowBounds);
        if (!isIntersectsRect) continue;
            CGPoint offset = CGPointMake(0, -tableView.contentInset.top);
            [tableView setContentOffset:offset animated:YES];
    }
    
}

/**
 * 搜索superview内部的所有子控件
 */
- (void)searchSubviews:(UIView *)superview
{
    for (UIScrollView *scrollView in superview.subviews) {
        [self searchSubviews:scrollView];
        
        // 判断是否为scrollView
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        // 计算出scrollView在window坐标系上的矩形框
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:scrollView.window];
        CGRect windowRect = scrollView.window.bounds;
        // 判断scrollView的边框是否和window的边框交叉
        if (!CGRectIntersectsRect(scrollViewRect, windowRect)) continue;
        
        // 让scrollView滚动到最前面
        CGPoint offset = scrollView.contentOffset;
        // 偏移量不一定是0
        offset.y = - scrollView.contentInset.top;
        [scrollView setContentOffset:offset animated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{//不实现这个，系统自带的状态栏就没了
    return NO;
}
@end
