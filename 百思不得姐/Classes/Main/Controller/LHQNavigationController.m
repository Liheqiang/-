//
//  LHQNavigationController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/14.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQNavigationController.h"

@implementation LHQNavigationController
/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    // 当导航栏用在LHQNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}

#pragma mark --- life cycle ---
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {//设置viewController的backItem没法自定义

        UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [backItem setTitle:@"返回" forState:UIControlStateNormal];
        [backItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backItem setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backItem setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backItem setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        backItem.size = backItem.currentImage.size;
        backItem.width = 60;
        backItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//控制类专用
        backItem.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);//靠左边近点//暂时只有这个方法!
        [backItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
        [viewController setHidesBottomBarWhenPushed:YES];//要注意！！！！  
    }
    
    [super pushViewController:viewController animated:animated];

}

- (void)back{
    
    [self popViewControllerAnimated:YES];
}

@end
