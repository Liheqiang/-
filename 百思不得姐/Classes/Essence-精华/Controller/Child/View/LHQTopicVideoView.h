//
//  LHQTopicVideoView.h
//  百思不得姐
//
//  Created by HqLee on 16/3/2.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHQTopic;
@interface LHQTopicVideoView : UIView

+ (instancetype)videoView;

@property (nonatomic, strong) LHQTopic *topic;

@end
