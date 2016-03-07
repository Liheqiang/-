//
//  UIImageView+LHQExtension.m
//  百思不得姐
//
//  Created by HqLee on 16/3/7.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "UIImageView+LHQExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LHQExtension)
- (void)downloadImageWithUrlSrting:(NSString *)urlString{
    
    WeakSelf
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] setCircleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      
//        LHQLog(@"%@",NSStringFromCGSize(image.size));
        weakSelf.image = image ? [image setCircleImage] : [[UIImage imageNamed:@"defaultUserIcon"] setCircleImage];
        
    }];
    
}

- (void)downloadImageWithUrlString:(NSString *)urlString withDownloadProgress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progress{
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        !progress ? :progress(receivedSize,expectedSize);
    } completed:nil];
    
}

@end
