//
//  QuestionSetsTrainingSessionViewController.m
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetsTrainingSessionViewController.h"
#import "AppData.h"
#import "QuestionSet.h"
#import "QuestionTrainingSessionViewController.h"
#import "Question.h"

@interface QuestionSetsTrainingSessionViewController ()

@end

@implementation QuestionSetsTrainingSessionViewController


#pragma mark - Selection

/**
 @brief It displays the details for the selected part of the user's balance.
 @author : Rémi Lavedrine
 @date : 27/08/2012
 @remarks : <#(optional)#>
 */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
  
    QuestionSet *currentQuestionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    NSMutableArray *questionsArray = currentQuestionSet.questionsArray;
    QuestionTrainingSessionViewController *questionViewController = [[QuestionTrainingSessionViewController alloc] initWithQuestionsArray:questionsArray];
  
  [self.navigationController pushViewControllerFromRight:questionViewController];
}

@end
