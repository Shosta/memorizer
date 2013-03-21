//
//  Question+Parser.m
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Question+Parser.h"

@implementation Question (Parser)


#pragma mark - Parsing

#define kStatementKey @"statement"
#define kAnswerKey @"answer"
#define kDescriptionKey @"description"
/**
 @brief Create a Question object from an NSdictionary object returned from the parsing.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
+ (Question *)parse:(NSDictionary *)questionDict{
    Question *aQuestion = [[Question alloc] init];
    
    // 1. Parse the question.
    NSString *question = [questionDict objectForKey:kStatementKey];
    if (question != nil) {
        aQuestion.statement = question;
    }
    
    // 2. Parse the answer.
    NSString *answer = [questionDict objectForKey:kAnswerKey];
    if (answer != nil) {
        aQuestion.answer = answer;
    }
    
    // 3. Parse the description.
    NSString *description = [questionDict objectForKey:kDescriptionKey];
    if (answer != nil) {
        aQuestion.description = description;
    }
    
    // 4. Add the next présentation date to now.
    aQuestion.nextPresentationDate = [NSDate date];
    
    return aQuestion;
}

@end
