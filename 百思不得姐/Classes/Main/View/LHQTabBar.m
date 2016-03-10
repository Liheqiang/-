//
//  LHQTabBar.m
//  百思不得姐
//
//  Created by HqLee on 16/2/14.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTabBar.h"
#import "LHQPublishView.h"

@interface LHQTabBar()

@property (nonatomic, weak) UIButton *publicButton;

@end
@implementation LHQTabBar

#pragma mark --- life cycle ---
- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publicButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publicButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publicButton.size = publicButton.currentBackgroundImage.size;
        [publicButton addTarget:self action:@selector(publicButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publicButton];
        self.publicButton = publicButton;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    static BOOL isAdd = YES;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publicButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    NSInteger index = 0;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    
    for (UIControl *button in self.subviews) {
        //排除非UITabBarButton 和手动添加的按钮
        if (![button isKindOfClass:[UIControl class]] || button == self.publicButton) continue;
        buttonX = buttonW * (index > 1 ? index + 1 :index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        if (isAdd) {
#warning 问题出在这里！！！！！UIControlEventTouchUpInside  之前使用的是UIControlEventTouchDown 导致选中的一直出错!!!!
            [button addTarget:self action:@selector(buttonSelected) forControlEvents:UIControlEventTouchUpInside];
        }

        index ++;
    }
    isAdd = NO;
    
}

- (void)buttonSelected{
    
    [LHQNotificationCenter postNotificationName:LHQTabBarDidSelectedNotification object:nil userInfo:nil];
    
}

- (void)publicButtonClick{
    [LHQPublishView show];
}

@end
