//
//  QuestionSet+Parser.m
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSet+Parser.h"
#import "Question.h"
#import "Question+Parser.h"

@implementation QuestionSet (Parser)

#define kQuestionsArrayKey @"questions"
#define kQuestionsArrayListKey @"list"
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
        NSDictionary *questionsDict = [json objectForKey:kQuestionsArrayKey];
        if (questionsDict != nil) {
            NSArray *questionsArray = [questionsDict objectForKey:kQuestionsArrayListKey];
            for (NSDictionary *questionDict in questionsArray) {
                [self.questionsArray addObject:[Question parse:questionDict]];
            }
        }   
    }
}

@end
