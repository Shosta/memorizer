//
//  NSDate+AddDays.m
//  Memorizer
//
//  Created by Rems on 07/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "NSDate+AddDays.h"

@implementation NSDate (AddDays)

- (NSDate *)addDays:(int)numberOfDays{
    NSDate *newDate = [self dateByAddingTimeInterval:60*60*24*numberOfDays];

    return newDate;
}

@end
