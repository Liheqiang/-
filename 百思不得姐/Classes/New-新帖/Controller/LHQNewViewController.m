//
//  LHQNewViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQNewViewController.h"

@interface LHQNewViewController ()

@end

@implementation LHQNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagClick)];
    
    self.view.backgroundColor = LHQGlobalBg;
}

- (NSString *)a{
    return @"newlist";
}



- (void)mainTagClick{
    
}

@end
