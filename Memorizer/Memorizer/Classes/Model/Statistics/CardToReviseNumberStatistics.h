//
//  CardToReviseNumberStatistics.h
//  Memorizer
//
//  Created by Rems on 07/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardToReviseNumberStatistics : NSObject

@property (nonatomic, retain) NSArray *questionsArray;

@property (nonatomic) int cardNumberToday;
@property (nonatomic) int cardNumberTomorrow;
@property (nonatomic) int cardNumberInTwoDays;
@property (nonatomic) int cardNumberInThreeDays;
@property (nonatomic) int cardNumberInFourDays;


#pragma mark - Object

- (id)initWithQuestionsArray:(NSArray *)aQuestionSetArray;

@end
