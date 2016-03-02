//
//  LHQBaseTopicCell.m
//  百思不得姐
//
//  Created by HqLee on 16/2/26.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQBaseTopicCell.h"
#import "LHQTopicPictureView.h"
#import "LHQTopicVoiceView.h"
#import "LHQTopicVideoView.h"
#import "LHQTopic.h"
#import <UIImageView+WebCache.h>

@interface LHQBaseTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (nonatomic, weak) LHQTopicPictureView *pictureView;
@property (nonatomic, weak) LHQTopicVoiceView *voiceView;
@property (nonatomic, weak) LHQTopicVideoView *videoView;

@end
@implementation LHQBaseTopicCell
#pragma mark --- lazy load ---
- (LHQTopicPictureView *)pictureView{       
    if (_pictureView == nil) {
        //    _pictureView = [LHQTopicPictureView pictureView];不能直接赋值,先添加在赋值
        LHQTopicPictureView *pictureView = [LHQTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (LHQTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        LHQTopicVoiceView *voiceView = [LHQTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (LHQTopicVideoView *)videoView{
    if (_videoView == nil) {
        LHQTopicVideoView *videoView = [LHQTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
#pragma mark --- life cycle ---
- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //细节处理，cell的背景图片设置;不让其拉伸是在assets里面设置的
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

#pragma mark --- setter ---
- (void)setTopic:(LHQTopic *)topic{
    
    _topic = topic;
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //昵称
    self.nickNameLabel.text = topic.screen_name;
    //创建时间
    self.timeLabel.text = topic.created_at;
    //正文
    self.text_label.text = topic.text;
    //设置按钮对应的数据
    [self setButton:self.dingButton number:topic.ding placeHolder :@"顶"];
    [self setButton:self.caiButton number:topic.cai placeHolder :@"踩"];
    [self setButton:self.repostButton number:topic.repost placeHolder :@"转发"];
    [self setButton:self.commentButton number:topic.comment placeHolder :@"评论"];
    
    //图片中间内容
    if (topic.type == LHQTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == LHQTopicTypeVoice){
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == LHQTopicTypeVideo){
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else{
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}

- (void)setButton:(UIButton *)button number:(NSInteger)number placeHolder :(NSString *)placeHolder{
    
    if (number > 1000) {
        placeHolder = [NSString stringWithFormat:@"%.1f万",(number / 10000.0)];
    }
    if (number < 1000 && number != 0) {
        placeHolder = [NSString stringWithFormat:@"%zd",number];
    }
    [button setTitle:placeHolder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame{

    frame.origin.x += LHQTopicCellMargin;
    frame.size.width -= 2 * LHQTopicCellMargin;
    frame.origin.y += LHQTopicCellMargin;
    frame.size.height -= LHQTopicCellMargin;
    
    [super setFrame:frame];
}

@end
