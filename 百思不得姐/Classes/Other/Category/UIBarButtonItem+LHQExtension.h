//
//  UIBarButtonItem+LHQExtension.h
//  百思不得姐
//
//  Created by HqLee on 16/2/14.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LHQExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target :(id)target action:(SEL)action;

@end
