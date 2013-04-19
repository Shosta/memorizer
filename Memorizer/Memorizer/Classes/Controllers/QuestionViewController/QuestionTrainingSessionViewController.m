//
//  QuestionTrainingSessionViewController.m
//  Memorizer
//
//  Created by Rems on 19/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionTrainingSessionViewController.h"

@interface QuestionTrainingSessionViewController ()

@end

@implementation QuestionTrainingSessionViewController


#pragma mark - Object

- (id)initWithQuestionsArray:(NSMutableArray *)aQuestionSetArray{
    return [self initWithNibName:@"QuestionTrainingSessionViewController" bundle:nil questionsArray:aQuestionSetArray];
}


#pragma mark - NavigationBar

- (void)addNavigationBarNextQuestionButton{
    // Create the "Next Question" button
    self.nextQuestionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
    [self.nextQuestionButton setImage:[UIImage imageNamed:@"nextQuestion.png"] forState:UIControlStateNormal];
    [self.nextQuestionButton addTarget:self action:@selector(displayNextQuestion) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [self.navigationItem setRightBarButtonItem:segmentBarItem animated:YES];
    
    [customView addSubview:self.nextQuestionButton];
}


#pragma mark - View

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self addNavigationBarNextQuestionButton];
}

@end
