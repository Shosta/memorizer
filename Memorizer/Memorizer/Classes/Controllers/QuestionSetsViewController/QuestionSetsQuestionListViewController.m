//
//  QuestionSetsQuestionListViewController.m
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetsQuestionListViewController.h"
#import "AppData.h"
#import "QuestionSet.h"
#import "QuestionsListViewController.h"
#import "Question.h"

@interface QuestionSetsQuestionListViewController ()

@end

@implementation QuestionSetsQuestionListViewController


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
    QuestionsListViewController *questionViewController = [[QuestionsListViewController alloc] initWithShortTitle:currentQuestionSet.shortTitle questionsArray:questionsArray];
    [self.navigationController pushViewControllerFromRight:questionViewController];
}

@end
