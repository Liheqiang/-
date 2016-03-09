//
//  LHQMeCell.m
//  百思不得姐
//
//  Created by HqLee on 16/3/9.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQMeCell.h"

@implementation LHQMeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //调整imageView的大小
    self.imageView.height = self.height * 0.5;
    self.imageView.width = self.imageView.height;
    self.imageView.centerY = self.height * 0.5;
    
    //调整有图片时，label的位置
    if (self.imageView.image) {
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + LHQTopicCellMargin;
    }
    
}
@end
