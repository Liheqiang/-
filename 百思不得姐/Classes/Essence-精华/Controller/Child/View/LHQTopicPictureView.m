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
#import "LHQProgressView.h"
#import "LHQShowPictureViewController.h"

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.imageView addGestureRecognizer:tap];
}

- (void)tap{
   
    LHQShowPictureViewController *showVc = [[LHQShowPictureViewController alloc] init];
    showVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVc animated:YES completion:nil];
    
    
}

- (void)setTopic:(LHQTopic *)topic{
    _topic = topic;
    
    [self.progressView setProgress:topic.pictureProgress animated:YES];
    WeakSelf
    //SDWeb如果发现是gif图片，会调用内部imageIO 然后将gif图片转为N个图片，进行播放 animationImages
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImageUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        weakSelf.progressView.hidden = NO;//cell的重用
        CGFloat progressValue = (double)receivedSize / expectedSize;
        NSString *progress = [NSString stringWithFormat:@"%f",progressValue];
        progress = [progress stringByReplacingOccurrencesOfString:@"-" withString:@""];//替换负值的情况
        topic.pictureProgress = [progress integerValue];
        [weakSelf.progressView setProgress:topic.pictureProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
        
        if (!topic.isBigPicture) return ;//非大图就不处理了
        
        CGSize maxSize = CGSizeMake(kScreenWidth - 4 * LHQTopicCellMargin, LHQTopicPictureDealH);
        UIGraphicsBeginImageContextWithOptions(maxSize, YES, 0.0);//获得图形上下文
        
        CGFloat pictureW = image.size.width;
        CGFloat pictureH = image.size.height;
        
        [image drawInRect:CGRectMake(0, 0, maxSize.width, maxSize.width * pictureH / pictureW)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();//关闭图形上下文
        
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
