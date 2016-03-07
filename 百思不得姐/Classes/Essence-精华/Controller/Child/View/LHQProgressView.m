//
//  LHQProgressView.m
//  百思不得姐
//
//  Created by HqLee on 16/2/29.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQProgressView.h"

@implementation LHQProgressView

- (void)awakeFromNib{
    
    self.roundedCorners = 5.0f;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    
    [super setProgress:progress animated:animated];
    
    //.0 表示小数点后保留0位
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
