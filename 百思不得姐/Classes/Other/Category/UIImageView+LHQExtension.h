//
//  UIImageView+LHQExtension.h
//  百思不得姐
//
//  Created by HqLee on 16/3/7.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LHQExtension)
//根据url字符串下载图片
- (void)downloadImageWithUrlSrting:(NSString *)urlString;

@end
