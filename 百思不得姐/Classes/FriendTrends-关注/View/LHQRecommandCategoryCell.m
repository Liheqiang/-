//
//  LHQRecommandCategoryCell.m
//  百思不得姐
//
//  Created by HqLee on 16/2/15.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQRecommandCategoryCell.h"
#import "LHQRecommandCategory.h"

static CGFloat const topMargin = 2.0;

@interface LHQRecommandCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *recommandIndicator;
@end
@implementation LHQRecommandCategoryCell

- (void)awakeFromNib {
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.textLabel.y = topMargin;
    self.textLabel.height = self.textLabel.height - 2 * topMargin;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.textLabel.textColor = selected ? [UIColor redColor] :[UIColor grayColor];
    self.backgroundColor = selected ? [UIColor whiteColor] : LHQGlobalBg;
    self.recommandIndicator.hidden = !selected;
}

#pragma mark -- setter && getter ---
- (void)setCategory:(LHQRecommandCategory *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}

@end
