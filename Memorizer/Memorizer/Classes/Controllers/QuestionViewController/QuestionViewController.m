//
//  QuestionViewController.m
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController


#pragma mark - View

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarTitle];
}


#pragma mark - NavigationBar

- (void)setNavigationBarTitle{
    int index = self.currentQuestionIndex + 1; // As arrays starts at "0" in Objective-C.
    int questionsCount  = [self.questionsArray count];
    
    NSString *title = [NSString stringWithFormat:@"Question %d sur %d", index, questionsCount];
    [self.navigationItem setTitle:title];
}


#pragma mark - NextQuestion

/**
 @brief Pop the QuestionSetsViewController as the Questions list is finished.
 @author : Rémi Lavedrine
 @date : 12/04/2013
 @remarks : It refresh the QuestionSetsViewController's TableView as well.
 */
- (void)popQuestionSetsViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 @brief Display the next Question on Screen.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : It removes all the question, answer and description from the previous Question. It loads the next one from the questionArray.
 It sets the navigationBar title to mention the question's number.
 If it's the last question from the QuestionSet, it pops to the RootViewController.
 */
- (void)displayNextQuestion{
    if (self.currentQuestionIndex + 1 < [self.questionsArray count]){ // As arrays starts at "0" in Objective-C.
        // 1. Change the question index.
        self.currentQuestionIndex = self.currentQuestionIndex + 1;
        
        // 2. Remove answer an description.
        self.shouldDisplayAnswer = [NSNumber numberWithBool:NO];
        self.shouldDisplayDescription = [NSNumber numberWithBool:NO];
        
        // 3. Reload the tableView with the new question.
        [self.tableView reloadData];
        
        // 4. Change the NavigationBar title.
        [self setNavigationBarTitle];
    }else{
        [self popQuestionSetsViewController];
    }
}

@end
