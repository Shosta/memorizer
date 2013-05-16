//
//  QuestionsListViewController.h
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSString *shortTitle;
@property (nonatomic, retain) NSMutableArray *questionsArray;


#pragma mark - Object
//! Object constructor.
//! @param[in]       aShortTitle : The Title for the NavigationBar that describes the QuestionSet.
//! @param[in] aQuestionSetArray : The Question array to display within the View.
- (id)initWithShortTitle:(NSString *)aShortTitle
          questionsArray:(NSMutableArray *)aQuestionSetArray;

@end
