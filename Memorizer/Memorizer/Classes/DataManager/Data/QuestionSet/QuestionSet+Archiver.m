//
//  QuestionSet+Archiver.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 12/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSet+Archiver.h"

@implementation QuestionSet (Archiver)

#pragma mark - Object

/**
 @brief Init method with a title, a short title, and an array of questions.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
- (id)initWithTitle:(NSString *)aTitle
         shortTitle:(NSString *)aShortTitle
      questionArray:(NSMutableArray *)aQuestionArray{
  self = [super init];
  if (self) {
    self.title = aTitle;
    self.shortTitle = aShortTitle;
    self.questionsArray = aQuestionArray;
  }
  
  return self;
}


#pragma mark - Archiving

#define kTitleKey @"title"
#define kShortTitleKey @"shortTitle"
#define kQuestionArrayKey @"list"
/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.title forKey:kTitleKey];
  [encoder encodeObject:self.shortTitle forKey:kShortTitleKey];
  [encoder encodeObject:self.questionsArray forKey:kQuestionArrayKey];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (id)initWithCoder:(NSCoder *)decoder {
  NSString       *t  = [decoder decodeObjectForKey:kTitleKey];
  NSString       *st = [decoder decodeObjectForKey:kShortTitleKey];
  NSMutableArray *q  = [decoder decodeObjectForKey:kQuestionArrayKey];
  
  return [self initWithTitle:t
                  shortTitle:st
               questionArray:q];
}

@end
