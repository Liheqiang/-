//
//  NSDate+LHQExtension.m
//  百思不得姐
//
//  Created by HqLee on 16/2/22.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "NSDate+LHQExtension.h"

@implementation NSDate (LHQExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from{
    
    //当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear{

    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDate *nowDate = [NSDate date];
    
    NSDateComponents *comps = [calender components:NSCalendarUnitYear fromDate:nowDate];
    
    NSDateComponents *selfComps = [calender components:NSCalendarUnitYear fromDate:self];
    
    return comps.year == selfComps.year;
    
}

- (BOOL)isToday{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDate *nowDate = [NSDate date];
    
    NSDateComponents *comps = [calender components:NSCalendarUnitYear fromDate:nowDate];
    
    NSDateComponents *selfComps = [calender components:NSCalendarUnitYear fromDate:self];
    
    return comps.year == selfComps.year
    && comps.month == selfComps.month
    && comps.day == selfComps.day;
}

- (BOOL)isYestoday{
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0
    && comps.month == 0
    && comps.day == 1;
}

@end
