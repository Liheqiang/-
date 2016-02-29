//
//  LHQMeViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQMeViewController.h"

@interface LHQMeViewController ()

@end

@implementation LHQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingItemClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    self.view.backgroundColor = LHQGlobalBg;

}

- (void)settingItemClick{
    
}

- (void)moonItemClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
