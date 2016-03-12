//
//  LHQTagTextField.h
//  百思不得姐
//
//  Created by HqLee on 16/3/12.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHQTagTextField : UITextField

@property (nonatomic, copy) void(^deleteBlock)();

@end
