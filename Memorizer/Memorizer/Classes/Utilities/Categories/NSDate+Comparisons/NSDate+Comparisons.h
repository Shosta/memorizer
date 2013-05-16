//
//  NSDate+Comparisons.h
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 16/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Comparisons)

- (BOOL)isLaterThanOrEqualTo:(NSDate*)date;
- (BOOL)isEarlierThanOrEqualTo:(NSDate*)date;
- (BOOL)isLaterThan:(NSDate*)date;
- (BOOL)isEarlierThan:(NSDate*)date;
- (BOOL)isSameDayAs:(NSDate *)date;


@end
