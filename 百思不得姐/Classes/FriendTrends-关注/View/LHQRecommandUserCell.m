//
//  LHQRecommandUserCell.m
//  百思不得姐
//
//  Created by HqLee on 16/2/15.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQRecommandUserCell.h"
#import "LHQRecommandUser.h"
#import <UIImageView+WebCache.h>

@interface LHQRecommandUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *header;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fanCountLabel;

@end

@implementation LHQRecommandUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --- setter && getter ---
- (void)setUser:(LHQRecommandUser *)user{
    _user = user;
    
    
    [self.header sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = user.screen_name;
    self.fanCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    
}

@end
