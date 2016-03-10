//
//  LHQPlaceholderTextView.m
//  百思不得姐
//
//  Created by HqLee on 16/3/10.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQPlaceholderTextView.h"

@interface LHQPlaceholderTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;

@end
@implementation LHQPlaceholderTextView
#pragma -
#pragma mark - initialize
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
#pragma -
#pragma mark - private method
- (void)initView{
    self.font = [UIFont systemFontOfSize:15];
    self.placeholderColor = [UIColor lightTextColor];
    
    //占位文字label
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.x = 5;
    placeholderLabel.y = 8;
    [self addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}


@end
