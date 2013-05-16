//
//  QuestionSetsStatisticsViewController.m
//  Memorizer
//
//  Created by Rems on 07/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetsStatisticsViewController.h"
#import "StatisticsViewController.h"
#import "QuestionSet.h"
#import "AppData.h"

@interface QuestionSetsStatisticsViewController ()

@end

@implementation QuestionSetsStatisticsViewController


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
    StatisticsViewController *statisticsViewController = [[StatisticsViewController alloc] initWithQuestionSet:currentQuestionSet];
  
  [self.navigationController pushViewControllerFromRight:statisticsViewController];
}

@end
