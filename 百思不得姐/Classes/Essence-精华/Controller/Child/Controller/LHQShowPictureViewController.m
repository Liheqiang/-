//
//  LHQShowPictureViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/29.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "LHQProgressView.h"
#import <SVProgressHUD.h>
#import "LHQTopic.h"

@interface LHQShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet LHQProgressView *progressView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation LHQShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    CGFloat pictureW = kScreenWidth;
    CGFloat pictureH = self.topic.height * pictureW / self.topic.width;
    if (pictureH > kScreenHeight) {
        
        CGFloat pictureX = 0;
        CGFloat pictureY = 0;
        imageView.frame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        self.scrollView.contentSize = imageView.frame.size;
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [imageView addGestureRecognizer:tap];
    WeakSelf
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.bigImageUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        weakSelf.progressView.hidden = NO;//cell的重用
        CGFloat progressValue = (double)receivedSize / expectedSize;
        NSString *progress = [NSString stringWithFormat:@"%f",progressValue];
        progress = [progress stringByReplacingOccurrencesOfString:@"-" withString:@""];//替换负值的情况
        weakSelf.topic.pictureProgress = [progress integerValue];
        [weakSelf.progressView setProgress:weakSelf.topic.pictureProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    
    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
    if (!self.imageView.image) {
        [SVProgressHUD showErrorWithStatus:@"图片还未下载完！"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
/**
 *  苹果官方建议的方法
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end
