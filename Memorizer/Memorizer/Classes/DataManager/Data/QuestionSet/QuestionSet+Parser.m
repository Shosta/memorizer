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
#define kTitleKey @"title"
#define kQuestionsArrayListKey @"list"

/**
 @brief Create a Question object from an NSdictionary object returned from the parsing.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
+ (QuestionSet *)parse:(NSDictionary *)questionSetDict{
    QuestionSet *aQuestionSet = [[QuestionSet alloc] init];
    
    // 1. Parse the Question Title.
    NSString *title = [questionSetDict objectForKey:kTitleKey];
    if (questionSetDict != nil) {
        aQuestionSet.title = title;
    }

    // 2. Parse the Question List.
    NSArray *questionsArray = [questionSetDict objectForKey:kQuestionsArrayListKey];
    for (NSDictionary *questionDict in questionsArray) {
        [aQuestionSet.questionsArray addObject:[Question parse:questionDict]];
    }
    
    return aQuestionSet;
}

@end
