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

/**
 @brief Return custom height from each row based on each row data and assuming it is a GenericBalanceCell. Else it returns 0.
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat minimumCellHeight = 115;
    CGFloat cellHeight = 0;
    QuestionSet *currentQuestionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    
    cellHeight = kCellQuestionSetTitleOriginMinorY + [self detailElementTextHeight:currentQuestionSet.title] + kCellQuestionSetPaddingY + kCellQuestionSetListInfoContainerViewHeight + kCellQuestionSetPaddingY;
    
    if (cellHeight < minimumCellHeight) {
        cellHeight = minimumCellHeight;
    }
    
    return cellHeight;
}

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
