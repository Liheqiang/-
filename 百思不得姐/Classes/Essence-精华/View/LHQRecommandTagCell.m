//
//  LHQRecommandTagCell.m
//  百思不得姐
//
//  Created by HqLee on 16/2/16.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQRecommandTagCell.h"
#import "LHQRecommandTag.h"
#import <UIImageView+WebCache.h>

@interface LHQRecommandTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation LHQRecommandTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommandTag:(LHQRecommandTag *)recommandTag{
    
    _recommandTag = recommandTag;
    
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommandTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = recommandTag.theme_name;
    
    self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",recommandTag.sub_number];
    
}

#pragma mark --- setter && getter---

- (void)setFrame:(CGRect)frame{ //非主流分割线作法！！！不错
    
    frame.size.height = frame.size.height - 1;
    
    frame.origin.x = frame.origin.x + 10;
    
    frame.size.width = frame.size.width - 20;
    
    [super setFrame:frame];
}

@end
