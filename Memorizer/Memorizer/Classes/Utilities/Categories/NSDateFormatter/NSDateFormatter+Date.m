//
//  NSDateFormatter+Date.m
//  MobinilAndMe
//
//  Created by Rémi Lavedrine on 11/10/12.
//  Copyright (c) 2012 France Telecom. All rights reserved.
//

#import "NSDateFormatter+Date.h"

@implementation NSDateFormatter (Date)


#pragma mark - Date Locale

- (void)addSettingsDateLocale{
  if (self != nil) {
    NSLocale *languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:[NSLocale currentLocale]];
    [self setLocale:languageLocale];
  }
}


#pragma mark - Date Formatter

+ (NSString *)dateStringFromString:(NSString *)sourceString
                      sourceFormat:(NSString *)sourceFormat
                 destinationFormat:(NSString *)destinationFormat{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter addSettingsDateLocale];
  [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  [dateFormatter setDateFormat:sourceFormat];
  NSDate *date = [dateFormatter dateFromString:sourceString];
  [dateFormatter setDateFormat:destinationFormat];
                                    
  return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)sourceString
              sourceFormat:(NSString *)sourceFormat{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter addSettingsDateLocale];
  [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  [dateFormatter setDateFormat:sourceFormat];
  NSDate *date = [dateFormatter dateFromString:sourceString];
                
  return date;
}

/**
 @brief Return a NSString from a NSDate object with the provided "Destination Format" and with the "Settings Locale".
 @author : Rémi Lavedrine
 @date : 14/02/2013 <3
 @remarks : <#(optional)#>
 */
+ (NSString *)dateStringFromDate:(NSDate *)date
                 destinationFormat:(NSString *)destinationFormat{
  NSString *formatString = [NSDateFormatter dateFormatFromTemplate:destinationFormat
                                                           options:0
                                                            locale:[NSLocale currentLocale]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:formatString];
                                    
  return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateStringForCurrentDateWithFormat:(NSString *)destinationFormat{
  return [self  dateStringFromDate:[NSDate date]
                 destinationFormat:destinationFormat];
}


@end


