//
//  NSDate+Comparisons.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 16/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "NSDate+Comparisons.h"

@implementation NSDate (Comparisons)

- (BOOL)isLaterThanOrEqualTo:(NSDate*)date {
  return !([self compare:date] == NSOrderedAscending);
}

- (BOOL)isEarlierThanOrEqualTo:(NSDate*)date {
  return !([self compare:date] == NSOrderedDescending);
}
- (BOOL)isLaterThan:(NSDate*)date {
  return ([self compare:date] == NSOrderedDescending);
  
}
- (BOOL)isEarlierThan:(NSDate*)date {
  return ([self compare:date] == NSOrderedAscending);
}

- (BOOL)isSameDayAs:(NSDate *)date {
  int days1 = [self  timeIntervalSince1970] / 86400;
  int days2 = [date timeIntervalSince1970] / 86400;
  return (days1 == days2);
}

- (BOOL)isTwoMonthLaterThan:(NSDate *)date{
    BOOL result = NO;
    
    int secondsInADay = 3600 * 24;
    int secondsInTwoMonths = secondsInADay * 60;
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:self];
    if(timeInterval > secondsInTwoMonths)
    {
        //It's been than two months.
        result = YES;
    }
    
    return result;
}


@end
