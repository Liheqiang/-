//
//  LHQUser.m
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQUser.h"
#import <MJExtension.h>

@implementation LHQUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID" : @"id"};
}

@end
