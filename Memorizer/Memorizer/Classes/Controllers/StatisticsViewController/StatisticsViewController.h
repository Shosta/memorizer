//
//  StatisticsViewController.h
//  Memorizer
//
//  Created by Rems on 03/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionSet.h"
#import "CardMemorizationLevelStatistics.h"
#import "CardToReviseNumberStatistics.h"

@interface StatisticsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *statisticsTableView;
@property (nonatomic, retain) QuestionSet *questionSet;
@property (nonatomic, retain) CardMemorizationLevelStatistics *cardMemorizationLevelStatistics;
@property (nonatomic, retain) CardToReviseNumberStatistics *cardToReviseNumberStatistics;


#pragma mark - Object
//! Object constructor.
//! @param[in] aQuestionSet : <#param description#>
- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet;

//! Object constructor.
//! @param[in]                     aQuestionSet : <#param description#>
//! @param[in] aCardMemorizationLevelStatistics : <#param description#>
- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet
cardMemorizationLevelStatistics:(CardMemorizationLevelStatistics *)aCardMemorizationLevelStatistics;

@end
