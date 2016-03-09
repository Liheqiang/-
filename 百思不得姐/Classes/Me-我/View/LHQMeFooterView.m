//
//  LHQMeFooterView.m
//  百思不得姐
//
//  Created by HqLee on 16/3/9.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQMeFooterView.h"
#import <UIButton+WebCache.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "LHQSquareButton.h"
#import "LHQSquare.h"
#import "LHQWebViewController.h"

@implementation LHQMeFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadData];
    }
    return self;
}

#pragma -
#pragma mark --- private method ---
- (void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *squares = [LHQSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        //最大列数
        NSInteger maxCol = 4;
        CGFloat buttonW = kScreenWidth / maxCol;
        CGFloat buttonH = buttonW;
        for (NSInteger i = 0; i < squares.count; i ++) {
            
            LHQSquare *square = squares[i];
            LHQSquareButton *button = [LHQSquareButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            button.square = square;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.size = CGSizeMake(buttonW, buttonH);
            
            CGFloat rowIndex = i / maxCol;
            CGFloat colIndex = i % maxCol;
            
            button.x = colIndex * buttonW;
            button.y = rowIndex * buttonH;
            
        }
        
        self.height = ((squares.count + maxCol - 1) / maxCol) * buttonH;
        [self setNeedsDisplay];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

- (void)buttonClick:(LHQSquareButton *)button{
    
    if (![button.square.url hasPrefix:@"http"])return;
    LHQWebViewController *webVc = [[LHQWebViewController alloc] init];
    webVc.url = button.square.url;
    
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navi = (UINavigationController *)tabBarVc.selectedViewController;
    [navi pushViewController:webVc animated:YES];
}

- (void)drawRect:(CGRect)rect{
    
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
    
}
@end
