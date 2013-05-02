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

static NSString *kShouldDisplayAnswerKey = @"shouldDisplayAnswer";
static NSString *kShouldDisplayDescriptionKey = @"shouldDisplayDescription";

@interface SingleQuestionViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *questionsArray;
@property int currentQuestionIndex;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UIButton *nextQuestionButton;
@property (weak, nonatomic) NSNumber *shouldDisplayAnswer;
@property (weak, nonatomic) NSNumber *shouldDisplayDescription;


#pragma mark - Object
//! Object constructor.
//! @param[in]      nibNameOrNil : The nib name or nil.
//! @param[in]    nibBundleOrNil : The nib bundle or nil.
//! @param[in] aQuestionSetArray : The Question array to display within the View.
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       questionsArray:(NSMutableArray *)aQuestionsArray;

//! Object constructor.
//! @param[in] aQuestionSetArray : The Question array to display within the View.
- (id)initWithQuestionsArray:(NSMutableArray *)aQuestionsArray;


#pragma mark - KVO
- (void)updateUIForKeypath:(NSString *)keyPath;


#pragma mark - Selection
- (void)displayAnswer;

@end
