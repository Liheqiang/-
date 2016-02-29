//
//  LHQTopicPictureView.h
//  百思不得姐
//
//  Created by HqLee on 16/2/29.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHQTopic;
@interface LHQTopicPictureView : UIView
@property (nonatomic, strong) LHQTopic *topic;

+ (instancetype)pictureView;

@end
