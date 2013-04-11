//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionViewController.h
// Created     : $ 28/03/13 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright France Telecom 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of France Telecom.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// France Telecom.
//--------------------------------------------------------
//
// @brief
// This ViewController displays a Question and handle all the user interactions to display the answer and the description.
// It handles as well the interaction to pass to the next question only when the user displays the answer.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *questionSetArray;
@property int currentQuestionIndex;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL shouldDisplayAnswer;
@property BOOL shouldDisplayDescription;


#pragma mark - Object
//! Object constructor.
//! @param[in]      nibNameOrNil : The nib name or nil.
//! @param[in]    nibBundleOrNil : The nib bundle or nil.
//! @param[in] aQuestionSetArray : The Question array to display within the View.
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
          questionSet:(NSMutableArray *)aQuestionSetArray;

//! Object constructor.
//! @param[in] aQuestionSetArray : The Question array to display within the View.
- (id)initWithQuestionSet:(NSMutableArray *)aQuestionSetArray;


#pragma mark - Selection

- (void)displayAnswer;


#pragma mark - NextQuestion
//! Display the next Question on Screen.
- (void)displayNextQuestion;

@end
