//
//  LHQPlaceholderTextView.h
//  百思不得姐
//
//  Created by HqLee on 16/3/10.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHQPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
