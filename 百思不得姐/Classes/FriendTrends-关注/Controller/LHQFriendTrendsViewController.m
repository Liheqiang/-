//
//  LHQFriendTrendsViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQFriendTrendsViewController.h"
#import "LHQRecommandViewController.h"
#import "LHQLoginViewController.h"

@interface LHQFriendTrendsViewController ()

@end

@implementation LHQFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsItemClick)];
    
    self.view.backgroundColor = LHQGlobalBg;

}

- (void)friendsItemClick{
    
//    LHQTestViewController *vc = [[LHQTestViewController alloc] init];
    LHQRecommandViewController *vc = [[LHQRecommandViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)loginRegister {
    LHQLoginViewController *loginVc = [[LHQLoginViewController alloc] init];
    
    [self presentViewController:loginVc animated:YES completion:nil];
    
}


@end
