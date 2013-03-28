//
//  AppData+Parser.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AppData+Parser.h"
#import "QuestionSet.h"
#import "QuestionSet+Parser.h"

@implementation AppData (Parser)

#define kQuestionSetsArrayListKey @"questionSets"

/**
 @brief Parse the
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
- (void)fetchedData:(NSData *)data{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    BOOL isValidJSONObject = [NSJSONSerialization isValidJSONObject:json];
    if (isValidJSONObject) {
        // 1. Parse the list of questions.
        NSArray *questionSetsArray = [json objectForKey:kQuestionSetsArrayListKey];
        if (questionSetsArray != nil) {
            for (NSDictionary *questionSetsDict in questionSetsArray) {
                [[APP_DATA questionSetsArray] addObject:[QuestionSet parse:questionSetsDict]];
            }
        }
    }
}

@end
