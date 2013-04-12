//
//  NextPresentationQuestionSet.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 12/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "NextPresentationQuestionSet.h"
#import "QuestionSet.h"
#import "Question.h"

@implementation NextPresentationQuestionSet


#pragma mark - Object

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (NSDate *)nextPresentationDateFromQuestionSet:(QuestionSet *)questionSet{
  NSArray *array = questionSet.questionsArray;
  NSDate *nextPresentationDate = [(Question *)[array lastObject] nextPresentationDate];
  
  NSDate *now = [NSDate date];
  for (Question *question in array) {
    if ([question.nextPresentationDate compare:nextPresentationDate] == NSOrderedAscending) {
      nextPresentationDate = question.nextPresentationDate;
    }
  }
  
  if ([nextPresentationDate compare:now] == NSOrderedAscending) {
    nextPresentationDate = now;
  }
  
  return nextPresentationDate;
}

/**
 @brief A Subset of the entire QuestionSetcomposed only with the Question from the QuestionSet whose "nextPresentationDate" are equal or previous to the current date (today).
 @author : Rémi Lavedrine
 @date : 12/04/2013
 @remarks : <#(optional)#>
 */
- (NSMutableArray *)nextPresentationSubArrayFromQuestionSet:(QuestionSet *)questionSet{
  NSMutableArray *nextPresentationSubArray = [[NSMutableArray alloc] initWithCapacity:0];
  
  NSArray *array = questionSet.questionsArray;
  NSDate *now = [NSDate date];
  for (Question *question in array) {
    if ([question.nextPresentationDate compare:now] == NSOrderedSame || [question.nextPresentationDate compare:now] == NSOrderedAscending) {
      [nextPresentationSubArray addObject:question];
    }
  }

  return nextPresentationSubArray;
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet{
  self = [super init];
  if (self != nil) {
    self.title = aQuestionSet.title;
    self.nextPresentationQuestionArray = [self nextPresentationSubArrayFromQuestionSet:aQuestionSet];
    self.nextPresentationDate = [self nextPresentationDateFromQuestionSet:aQuestionSet];
  }
  
  return self;
}

@end
