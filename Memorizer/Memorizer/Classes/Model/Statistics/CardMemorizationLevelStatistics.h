//
//  CardMemorizationLevelStatistics.h
//  Memorizer
//
//  Created by Rems on 07/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardMemorizationLevelStatistics : NSObject

@property (nonatomic, retain) NSArray *questionsArray;
@property (nonatomic) float level1Number;
@property (nonatomic) float level1Percent;

@property (nonatomic) float level2Number;
@property (nonatomic) float level2Percent;

@property (nonatomic) float level3Number;
@property (nonatomic) float level3Percent;

@property (nonatomic) float level4Number;
@property (nonatomic) float level4Percent;

@property (nonatomic) float level5Number;
@property (nonatomic) float level5Percent;


#pragma mark - Object

- (id)initWithQuestionsArray:(NSArray *)aQuestionSetArray;

@end
