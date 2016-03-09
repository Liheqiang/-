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
    
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publicButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    NSInteger index = 0;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    
    for (UIControl *subView in self.subviews) {
        //排除非UITabBarButton 和手动添加的按钮
        if (![subView isKindOfClass:[UIControl class]] || subView == self.publicButton) continue;
        
        buttonX = buttonW * (index > 1 ? index + 1 :index);
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [subView addTarget:self action:@selector(buttonSelected) forControlEvents:UIControlEventTouchDown];
        index ++;
    }
    
}

- (void)buttonSelected{
    
    [LHQNotificationCenter postNotificationName:LHQTabBarSelectedNotification object:nil];
    
}

- (void)publicButtonClick{
    [LHQPublishView show];
}

@end
