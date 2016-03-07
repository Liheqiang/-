//
//  LHQCommentCell.m
//  百思不得姐
//
//  Created by HqLee on 16/3/6.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQCommentCell.h"
#import "LHQTopicComment.h"
#import <UIImageView+WebCache.h>

@interface LHQCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
@implementation LHQCommentCell

- (void)awakeFromNib {
   
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
}

#pragma -
#pragma mark - Setter/Getter
- (void)setComment:(LHQTopicComment *)comment{
    
    _comment = comment;
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@""]];
    //昵称
    self.nameLabel.text = comment.user.username;
    //性别
    self.sexView.image = [comment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    //点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    //评论内容
    self.contentLabel.text = comment.content;
}

@end
