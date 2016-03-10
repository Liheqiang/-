//
//  LHQPublishView.m
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQPublishView.h"
#import "LHQVerticalButton.h"
#import <POP.h>

@interface LHQPublishView()

@end

static CGFloat const buttonW = 72.f;
static CGFloat const buttonH = 102.f;
static CGFloat const margin = 20.f;


@implementation LHQPublishView

static UIWindow *window_;

+ (instancetype)publishView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show{
    
    LHQPublishView *publishView = [LHQPublishView publishView];
    window_ = [UIApplication sharedApplication].keyWindow;
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

- (void)awakeFromNib{
    
    self.userInteractionEnabled = NO;
    window_.userInteractionEnabled = NO;
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线"];
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    NSInteger maxCol = 3;
    CGFloat buttonStartY = (kScreenHeight - buttonH * (maxCol - 1)) / (maxCol - 1);
    CGFloat buttonMargin = (kScreenWidth - buttonW *maxCol - margin *(maxCol - 1)) / (maxCol - 1);
    CGFloat rowIndex = 0;
    CGFloat colIndex = 0;
    for (NSInteger i = 0; i < images.count; i ++) {
        
        rowIndex = i / 3;
        colIndex = i % 3;
        
        buttonX = margin + (buttonW + buttonMargin) * colIndex;
        buttonY = buttonStartY + rowIndex * (buttonH + buttonMargin);
        
        LHQVerticalButton *button = [[LHQVerticalButton alloc] init];
        [self addSubview:button];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.beginTime = CACurrentMediaTime() + i * 0.1;
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonH - kScreenHeight, 0, 0)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button pop_addAnimation:anim forKey:nil];
    }
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    sloganView.center = CGPointMake(kScreenWidth * 0.5, -(kScreenHeight + 2 *sloganView.height));
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganView.centerX, kScreenHeight *0.2)];
    [sloganView pop_addAnimation:anim forKey:nil];
    WeakSelf
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        weakSelf.userInteractionEnabled = YES;
        window_.userInteractionEnabled = YES;
    }];

}

- (void)cancleWithCompletionBlock:(void(^)())completion{
    
    WeakSelf
    self.userInteractionEnabled = NO;
    window_.userInteractionEnabled = NO;
    NSInteger startIndex = 2;
    for (NSInteger i = startIndex; i < self.subviews.count; i ++) {
        UIView *subview = self.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.beginTime = CACurrentMediaTime() + i * 0.1;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, kScreenHeight + subview.height)];
        [subview pop_addAnimation:anim forKey:nil];
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [weakSelf removeFromSuperview];
                !completion ? :completion();
            }];
        }
    }
    
}

- (void)dealloc{
    window_.userInteractionEnabled = YES;
}

- (void)buttonClick:(UIButton *)button{
    
    switch (button.tag) {
        case LHQPublishViewButtonTypeVideo:
            [self cancleWithCompletionBlock:^{
                LHQLog(@"发视频");
            }];
            break;
        case LHQPublishViewButtonTypePicture:
            [self cancleWithCompletionBlock:^{
                LHQLog(@"发图片");
            }];
            break;
        case LHQPublishViewButtonTypeText:
            [self cancleWithCompletionBlock:^{
                LHQLog(@"发段子");
            }];
            break;
        case LHQPublishViewButtonTypeAudio:
            [self cancleWithCompletionBlock:^{
                LHQLog(@"发声音");
            }];
            break;
        case LHQPublishViewButtonTypeReview:
            [self cancleWithCompletionBlock:^{
                LHQLog(@"审帖");
            }];
            break;
        case LHQPublishViewButtonTypeOffline:
            [self cancleWithCompletionBlock:^{
                LHQLog(@"离线下载");
            }];
            break;
        default:
            break;
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancleWithCompletionBlock:nil];
}

- (IBAction)cancle:(UIButton *)sender {
    [self cancleWithCompletionBlock:nil];
}


@end
