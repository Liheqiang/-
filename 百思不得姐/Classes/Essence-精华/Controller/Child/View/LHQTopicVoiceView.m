//
//  LHQTopicVoiceView.m
//  百思不得姐
//
//  Created by HqLee on 16/3/2.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTopicVoiceView.h"
#import "LHQTopic.h"
#import <UIImageView+WebCache.h>

@interface LHQTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end

@implementation LHQTopicVoiceView

+ (instancetype)voiceView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    [self insertSubview:self.imageView atIndex:1];
}

- (void)setTopic:(LHQTopic *)topic{
    
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImageUrl]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minutes = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,second];
}


@end
