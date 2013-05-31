//
//  QuestionSetStatisticsInfo.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 31/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetStatisticsInfo.h"
#import "QuestionSet.h"
#import "CardMemorizationLevelStatistics.h"

@implementation QuestionSetStatisticsInfo

- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet{
  self = [super init];
  if (self) {
    self.questionSetTitle = aQuestionSet.title;
    self.questionSetTotalCardsNumber = [NSString stringWithFormat:@"%d", aQuestionSet.questionsArray.count];
    
    CardMemorizationLevelStatistics *cardMemorizationLevelStatistics = [[CardMemorizationLevelStatistics alloc] initWithQuestionsArray:aQuestionSet.questionsArray];
    self.level1CardSatistiscs = [NSString stringWithFormat:@"(%0.0f%%) %0.0f", cardMemorizationLevelStatistics.level1Percent, cardMemorizationLevelStatistics.level1Number];
    self.level2CardSatistiscs = [NSString stringWithFormat:@"(%0.0f%%) %0.0f", cardMemorizationLevelStatistics.level2Percent, cardMemorizationLevelStatistics.level2Number];
    self.level3CardSatistiscs = [NSString stringWithFormat:@"(%0.0f%%) %0.0f", cardMemorizationLevelStatistics.level3Percent, cardMemorizationLevelStatistics.level3Number];
  }
  
  return self;
}
@end
