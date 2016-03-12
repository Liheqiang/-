//
//  LHQTagTextField.m
//  百思不得姐
//
//  Created by HqLee on 16/3/12.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTagTextField.h"

@implementation LHQTagTextField
#pragma -
#pragma mark - UIKeyInput
- (void)deleteBackward{
    
    !self.deleteBlock? :self.deleteBlock();
    [super deleteBackward];
}

@end
