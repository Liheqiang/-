//
//  LHQTextField.m
//  百思不得姐
//
//  Created by HqLee on 16/2/17.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQTextField.h"
#import <objc/runtime.h>

static NSString *const LHQTextFieldPlaceHolderKeyPath = @"_placeholderLabel.textColor";

@implementation LHQTextField

// 1.改变Placeholder的颜色等属性
//- (void)drawPlaceholderInRect:(CGRect)rect{
//    
//    [self.placeholder drawInRect:CGRectMake(0, 10, self.width, self.font.lineHeight) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],
//          NSForegroundColorAttributeName:[UIColor grayColor]
//                                                       }];
//}

//+ (void)initialize{
//    
//    unsigned int count = 0;
//    
//    //获得textField内部成员变量
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (NSInteger i = 0; i < count; i ++) {
//        
//        Ivar ivar = *((ivars + i));
//        Ivar ivar = ivars[i];  和上面的等价的
//        
//        LHQLog(@"%s",ivar_getName(ivar));
//        
//    }
//    
//    //释放内存
//    free(ivars);
//    
//}


- (void)awakeFromNib{
    
//    UILabel *placeHolder = [self valueForKeyPath:LHQTextFieldPlaceHolderKeyPath];
//    placeHolder.textColor = [UIColor grayColor];
    
    //通过kvc直接改变textField内部的placeHolder的文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:LHQTextFieldPlaceHolderKeyPath];
    self.tintColor = [UIColor whiteColor];//改变光标颜色
    self.textColor = [UIColor whiteColor];//输入文字颜色
    
}

/**
 *  先通过runTime获取内部成员变量，在通过kvc来操作内部成员变量属性🐂👃
 */

- (BOOL)becomeFirstResponder{
    
    [self setValue:[UIColor whiteColor] forKeyPath:LHQTextFieldPlaceHolderKeyPath];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    
    [self setValue:[UIColor grayColor] forKeyPath:LHQTextFieldPlaceHolderKeyPath];
    
    return [super resignFirstResponder];
}

@end
