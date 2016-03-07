//
//  UIImage+LHQExtension.m
//  百思不得姐
//
//  Created by HqLee on 16/3/7.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "UIImage+LHQExtension.h"

@implementation UIImage (LHQExtension)
/**
 *  设置圆形图片
 */
- (void)setCircleImage{
    //开启图形上下文
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获得当前图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //添加一个圆到图形上下文
    CGContextAddEllipseInRect(ref, CGRectMake(0, 0, self.size.width, self.size.height));
    
    //绘制到图形上下文
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //裁剪图形上下文
    CGContextClip(ref);
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
}
@end
