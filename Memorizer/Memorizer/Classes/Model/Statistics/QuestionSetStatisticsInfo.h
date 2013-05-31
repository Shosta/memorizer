//
//  QuestionSetStatisticsInfo.h
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 31/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QuestionSet;


@interface QuestionSetStatisticsInfo : NSObject

@property (nonatomic, retain) NSString *questionSetTotalCardsNumber;
@property (nonatomic, retain) NSString *questionSetTitle;
@property (nonatomic, retain) NSString *level1CardSatistiscs ;
@property (nonatomic, retain) NSString *level2CardSatistiscs;
@property (nonatomic, retain) NSString *level3CardSatistiscs;


#pragma mark - Birth
- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet;

@end
