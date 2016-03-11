//
//  LHQTagButton.m
//  百思不得姐
//
//  Created by HqLee on 16/3/11.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTagButton.h"

@implementation LHQTagButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = LHQRGB(137, 218, 250);
        self.titleLabel.font =[UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.x = LHQTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + LHQTagMargin;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    self.width += 3 * LHQTagMargin;
    
}

@end
