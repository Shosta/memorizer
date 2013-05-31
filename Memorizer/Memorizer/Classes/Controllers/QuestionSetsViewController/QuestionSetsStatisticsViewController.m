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
#import "CardMemorizationLevelStatistics.h"
#import "NSDateFormatter+Date.h"
#import "QuestionSet.h"
#import "QuestionSetStatisticsTableViewCell.h"
#import "NSString+LabelSize.h"
#import "QuestionSetStatisticsInfo.h"

@interface QuestionSetsStatisticsViewController ()
@property (nonatomic, retain) NSMutableArray *questionSetStatisticsInfoArray;
@end

@implementation QuestionSetsStatisticsViewController


#pragma mark - View

- (void)viewDidLoad{
  [super viewDidLoad];
  
  self.questionSetStatisticsInfoArray = [[NSMutableArray alloc] initWithCapacity:0];
  for (QuestionSet *aQuestionSet in [APP_DATA questionSetsArray]) {
    QuestionSetStatisticsInfo *questionSetStatisticsInfo = [[QuestionSetStatisticsInfo alloc] initWithQuestionSet:aQuestionSet];
    [self.questionSetStatisticsInfoArray addObject:questionSetStatisticsInfo];
  }
}

#pragma mark - QuestionSetCell

/**
 @brief Format the date to handle
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (NSString *)formatDate:(NSDate *)date dateFormatTemplate:(NSString *)dateFormatTemplate{
    NSString *formattedDate = [NSDateFormatter dateStringFromDate:date
                                                destinationFormat:dateFormatTemplate];
    
    return formattedDate;
}

/**
 @brief Format the date with the day, the month and the year.
 @author : Rémi Lavedrine
 @date : 13/02/2013
 @remarks : <#(optional)#>
 */
- (NSString *)dayMonthYearFormatDate:(NSDate *)date{
    NSString *dateFormatted = [self formatDate:date dateFormatTemplate:kDayMonthYearFormatDate];
    
    return dateFormatted;
}

- (void)configureCell:(QuestionSetStatisticsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
  QuestionSetStatisticsInfo *questionSetStatisticsInfo = [self.questionSetStatisticsInfoArray objectAtIndex:indexPath.row];
  
  // Set the number of questions for this set.
  [cell.nextDateQuestionsNumberLabel setText:questionSetStatisticsInfo.questionSetTotalCardsNumber];
  
  // Set the Question Set Title.
  [cell.textLabel setText:questionSetStatisticsInfo.questionSetTitle];

  // Set the Statistics info.
  [cell.level1CardSatistiscs setText:questionSetStatisticsInfo.level1CardSatistiscs];
  [cell.level2CardSatistiscs setText:questionSetStatisticsInfo.level2CardSatistiscs];
  [cell.level3CardSatistiscs setText:questionSetStatisticsInfo.level3CardSatistiscs];
}

/**
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"QuestionSetStatisticsTableViewCellIdentifier";
    QuestionSetStatisticsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionSetStatisticsTableViewCell"
                                                                 owner:self
                                                               options:nil];
        
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[QuestionSetStatisticsTableViewCell class]]){
                cell = (QuestionSetStatisticsTableViewCell *) currentObject;
                break;
            }
        }
        [cell setCellStyle:QuestionSetTableViewCellMinorStyle];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Height

/**
 @brief Return the height of a BalanceDetailPartTableViewCell cell based on its labels' texts and the associated fonts.
 @author : Rémi Lavedrine
 @date : 28/08/2012
 @remarks : <#(optional)#>
 */
- (CGFloat)detailElementTextHeight:(NSString *)detailElementText{
    CGFloat detailElementTextHeight = [detailElementText getTextHeightAtFont:QUESTIONSET_CELL_TEXT_FONT forWidth:kCellAnswerDefaultTextWidth];
    
    return detailElementTextHeight ;
}

/**
 @brief Return custom height from each row based on each row data and assuming it is a GenericBalanceCell. Else it returns 0.
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat minimumCellHeight = 304;
    CGFloat cellHeight = 0;
    QuestionSet *currentQuestionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
        
    cellHeight = kCellQuestionSetTitleOriginMajorY + [self detailElementTextHeight:currentQuestionSet.title] + kCellQuestionSetStatisticsInfoContainerViewHeight;
    
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
    CardMemorizationLevelStatistics *currentCardMemorizationLevelStatistics = [[CardMemorizationLevelStatistics alloc] initWithQuestionsArray:currentQuestionSet.questionsArray];
    
    StatisticsViewController *statisticsViewController = [[StatisticsViewController alloc] initWithQuestionSet:currentQuestionSet cardMemorizationLevelStatistics:currentCardMemorizationLevelStatistics];
  
  [self.navigationController pushViewControllerFromRight:statisticsViewController];
}

@end
