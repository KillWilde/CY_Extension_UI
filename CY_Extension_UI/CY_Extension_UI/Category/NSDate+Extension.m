//
//  NSDate+Extension.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/11.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

//MARK: NSDate转NSString
- (NSString *)getYMD{
    // 不同地区日历 都转化为标准日历输出
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setCalendar:gregorian];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormat stringFromDate:self];
}

- (NSString *)getHMS{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter* timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setCalendar:gregorian];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    
    return [timeFormat stringFromDate:self];
}

- (NSString *)getYMDHMS{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setCalendar:gregorian];
    [dateFormat setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    
    return [dateFormat stringFromDate:self];
}

@end
