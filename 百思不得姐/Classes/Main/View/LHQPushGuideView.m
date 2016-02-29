//
//  LHQPushGuideView.m
//  百思不得姐
//
//  Created by HqLee on 16/2/18.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQPushGuideView.h"

static NSString *const versionKey = @"CFBundleShortVersionString";

@implementation LHQPushGuideView

+ (void)show{
    
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][versionKey];
    NSString *sandboxVersion = [LHQUserDefault stringForKey:versionKey];
    
    if (currentVersion != sandboxVersion) {
        
        LHQPushGuideView *guideView = [self guideView];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        guideView.frame = window.frame;
        
        [window addSubview:guideView];
        
        //存储当前版本号到沙盒
        [LHQUserDefault setObject:currentVersion forKey:versionKey];
        [LHQUserDefault synchronize];//立即存储，避免出现啥问题？
        
    }
    
}

+ (instancetype)guideView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LHQPushGuideView" owner:nil options:nil] firstObject];
    
}

- (IBAction)closePushGuideView:(id)sender {
    
    [self removeFromSuperview];
    
}

@end
