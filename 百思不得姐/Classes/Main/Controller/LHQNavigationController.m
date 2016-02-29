//
//  LHQNavigationController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/14.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQNavigationController.h"

@implementation LHQNavigationController

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
