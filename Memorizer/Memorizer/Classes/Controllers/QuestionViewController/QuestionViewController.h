//
//  QuestionViewController.h
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "SingleQuestionViewController.h"

@interface QuestionViewController : SingleQuestionViewController


#pragma mark - NextQuestion
//! Pop the QuestionSetsViewController as the Questions list is finished.
- (void)popQuestionSetsViewController;

//! Display the next Question on Screen.
- (void)displayNextQuestion;

@end
