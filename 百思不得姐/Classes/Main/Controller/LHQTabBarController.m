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


- (void)buttonClick{
    
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    LHQLogFun
    LHQLog(@"%@",tabBar.selectedViewController);
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    CGFloat width = self.tabBar.width;
    CGFloat height = self.tabBar.height;
    
    self.publicButton.center = CGPointMake(width * 0.5, height * 0.5);

    LHQEssenceViewController *essenceVc = [[LHQEssenceViewController alloc] init];
    [self addChildVc:essenceVc title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    LHQNewViewController *newVc = [[LHQNewViewController alloc] init];
    [self addChildVc:newVc title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    LHQFriendTrendsViewController *friendTrendsVc = [[LHQFriendTrendsViewController alloc] init];
    [self addChildVc:friendTrendsVc title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    LHQMeViewController *meVc = [[LHQMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:meVc title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //替换系统的 tabBar kvc
    [self setValue:[[LHQTabBar alloc] init] forKey:@"tabBar"];
    
    //注册监听
    [LHQNotificationCenter addObserver:self selector:@selector(buttonClick) name:LHQTabBarSelectedNotification object:nil];
    
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
