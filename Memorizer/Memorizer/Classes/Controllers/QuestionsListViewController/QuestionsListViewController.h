//
//  QuestionsListViewController.h
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *questionsArray;


#pragma mark - Object
//! Object constructor.
//! @param[in] aQuestionSetArray : The Question array to display within the View.
- (id)initWithQuestionsArray:(NSMutableArray *)aQuestionsArray;

@end
