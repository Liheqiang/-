//
//  LHQSquareButton.m
//  百思不得姐
//
//  Created by HqLee on 16/3/9.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQSquareButton.h"
#import "LHQsquare.h"
#import <UIButton+WebCache.h>

@implementation LHQSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //调整图片的frame
    self.imageView.y = LHQTopicCellMargin;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    //调整文字的frame
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.imageView.height;
    
}

#pragma -
#pragma mark - setter/getter
- (void)setSquare:(LHQSquare *)square{
    
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end
