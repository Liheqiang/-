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
    
    self.alwaysBounceVertical = YES;
    self.font = [UIFont systemFontOfSize:15];
    //占位文字label
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.x = 5;
    placeholderLabel.y = 6;
    placeholderLabel.textColor = [UIColor lightGrayColor];
    placeholderLabel.numberOfLines = 0;
    [self addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    //监听通知
    [LHQNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc{
    [LHQNotificationCenter removeObserver:self];
}


- (void)textChange{
    
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma -
#pragma mark - setter / getter
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    
    [super setText:text];
    
    [self textChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    [self textChange];;
}

@end
