//
// Created by efeng on 2017/3/18.
// Copyright (c) 2017 weiboyi. All rights reserved.
//

#import "NSDate+FYCompare.h"


@implementation NSDate (FYCompare)

- (BOOL)fy_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                    | NSCalendarUnitMonth
                    | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                    | NSCalendarUnitMonth
                    | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)fy_isTomorrow {
    return [self fy_isSameDay:[NSDate fy_dateTomorrow]];
}

- (BOOL)fy_isToday {
    return [self fy_isSameDay:[NSDate fy_dateToday]];
}

- (BOOL)fy_isYesterday {
    return [self fy_isSameDay:[NSDate fy_dateYesterday]];
}

+ (NSDate *)fy_dateTomorrow {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:[NSDate date] options:0];
}

+ (NSDate *)fy_dateToday {
    return [NSDate date];
}

+ (NSDate *)fy_dateYesterday {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:[NSDate date] options:0];
}

- (BOOL)fy_isEarlierThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)fy_isLaterThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)fy_isInFuture {
    return ([self fy_isLaterThanDate:[NSDate date]]);
}

- (BOOL)fy_isInPast {
    return ([self fy_isEarlierThanDate:[NSDate date]]);
}

@end