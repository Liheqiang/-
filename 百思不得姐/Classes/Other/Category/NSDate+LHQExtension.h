//
//  NSDate+LHQExtension.h
//  百思不得姐
//
//  Created by HqLee on 16/2/22.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LHQExtension)
//self 与 from的时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)from;

- (BOOL)isThisYear;

- (BOOL)isToday;

- (BOOL)isYestoday;

@end
