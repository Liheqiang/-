//
//  UIBarButtonItem+LHQExtension.m
//  百思不得姐
//
//  Created by HqLee on 16/2/14.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "UIBarButtonItem+LHQExtension.h"

@implementation UIBarButtonItem (LHQExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
