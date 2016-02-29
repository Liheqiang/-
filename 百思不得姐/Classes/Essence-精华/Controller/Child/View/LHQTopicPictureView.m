//
//  LHQTopicPictureView.m
//  百思不得姐
//
//  Created by HqLee on 16/2/29.
//  Copyright © 2016年 HqLee. All rights reserved.
//  图片帖子中间的控件

/**
 *  在不知道图片的真实扩展名，只能用图片数据的第一个字节，判断，也是最准确的
 */
#import "LHQTopicPictureView.h"
#import "LHQTopic.h"
#import <UIImageView+WebCache.h>
#import <MRCircularProgressView.h>

@interface LHQTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *progressView;


@end
@implementation LHQTopicPictureView

+ (instancetype)pictureView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;//如果发现图片明明设置为固定尺寸，但是实际显示是拉伸的，那可能是因为这个属性，因为，我们重写了cell的frame方法，改变了尺寸
    self.progressView.borderWidth = 0;
    self.progressView.lineWidth = 10;
//    self.progressView.
}

- (void)setTopic:(LHQTopic *)topic{
    _topic = topic;
    
    WeakSelf
    //SDWeb如果发现是gif图片，会调用内部imageIO 然后将gif图片转为N个图片，进行播放 animationImages
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImageUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        weakSelf.progressView.hidden = NO;//cell的重用
        CGFloat progressValue = (double)receivedSize / expectedSize;
        
        [weakSelf.progressView setProgress:progressValue animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    
    NSString *imageUrl = topic.bigImageUrl;
    
    self.gifImageView.hidden = ![imageUrl.pathExtension.lowercaseString isEqualToString:@"gif"];
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;//带有scale的模式，表面按照宽或高比例进行压缩
    }
    
}
- (IBAction)seeBigButtonClick {
}

@end
