//
//  LHQTopWindow.m
//  百思不得姐
//
//  Created by HqLee on 16/3/7.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTopWindow.h"
#import "LHQTopWindowViewController.h"

@implementation LHQTopWindow

static UIWindow *window_;

+ (void)initialize{
    window_ = [[self alloc] init];
}

+ (void)show{
    window_.hidden = NO;
    window_.backgroundColor = [UIColor clearColor];
}

+ (void)hide{
    window_.hidden = YES;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelAlert;
        self.rootViewController = [[LHQTopWindowViewController alloc] init];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    
    frame = [UIApplication sharedApplication].statusBarFrame;
    
    [super setFrame:frame];
}


@end
