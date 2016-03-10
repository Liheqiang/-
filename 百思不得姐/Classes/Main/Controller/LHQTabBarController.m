//
//  LHQTabBarController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTabBarController.h"
#import "LHQEssenceViewController.h"
#import "LHQNewViewController.h"
#import "LHQFriendTrendsViewController.h"
#import "LHQMeViewController.h"
#import "LHQTabBar.h"
#import "LHQNavigationController.h"


@interface LHQTabBarController ()

@property (nonatomic, strong) UIButton *publicButton;

@end

@implementation LHQTabBarController
#pragma mark --- life cycle ---
+(void)initialize{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    
    selectedAttr[NSFontAttributeName] = attr[NSFontAttributeName];
    
    selectedAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addChildVc:[[LHQEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    [self addChildVc:[[LHQNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self addChildVc:[[LHQFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];

    [self addChildVc:[[LHQMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //替换系统的 tabBar kvc
    [self setValue:[[LHQTabBar alloc] init]forKeyPath:@"tabBar"];
    
}

#pragma mark --- private method ---

- (void)addChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    [vc.tabBarItem setTitle:title];
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    LHQNavigationController *navi = [[LHQNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
    
}

@end
