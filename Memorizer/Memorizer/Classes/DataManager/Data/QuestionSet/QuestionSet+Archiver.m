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
 @brief Init method with a statement string, a answer string, a description string and a nextPresentationDate date.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
- (id)initWithTitle:(NSString *)aTitle
      questionArray:(NSMutableArray *)aQuestionArray{
  self = [super init];
  if (self) {
    self.title = aTitle;
    self.questionsArray = aQuestionArray;
  }
  
  return self;
}


#pragma mark - Archiving

#define kTitleKey @"title"
#define kQuestionArrayKey @"list"
/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.title forKey:kTitleKey];
  [encoder encodeObject:self.questionsArray forKey:kQuestionArrayKey];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (id)initWithCoder:(NSCoder *)decoder {
  NSString       *t = [decoder decodeObjectForKey:kTitleKey];
  NSMutableArray *q = [decoder decodeObjectForKey:kQuestionArrayKey];
  
  return [self initWithTitle:t
               questionArray:q];
}

@end
