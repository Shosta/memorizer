//
//  QuestionSetsViewController.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 12/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetsViewController.h"
#import "AppData.h"
#import "NSDateFormatter+Date.h"
#import "NSString+LabelSize.h"
#import "QuestionSet.h"
#import "QuestionSetTableViewCell.h"
#import "QuestionTrainingSessionViewController.h"
#import "Question.h"

@implementation QuestionSetsViewController


#pragma mark - View

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
    [self.view setBackgroundColor:color];
    
    [self.navigationItem setTitle:@"Ultimemo"];
}


#pragma mark - Cell Count

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView{
    int sectionCount = 1;
    
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
    int rowsInSection = [[APP_DATA questionSetsArray] count];
    
    return rowsInSection;
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

/**
 @brief Calculate the gauge progress percent according to the question saved memorization level.
 @author : Rémi Lavedrine
 @date : 19/04/2013
 @remarks : <#(optional)#>
 */
- (float)questionDonePercentAtIndexPath:(NSIndexPath *)indexPath{
    QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    NSArray *questionArray = [questionSet questionsArray];
    
    float allQuestionsDoneNumber = [questionArray count] * MemorizationLevel5;
    float questionsDoneNumber = 0.0f;
    for (Question *question in questionArray) {
        questionsDoneNumber = questionsDoneNumber + question.userLastMemorizationLevel;
    }
    
    float percent = questionsDoneNumber / allQuestionsDoneNumber;
    
    return percent;
}

- (void)configureCell:(QuestionSetTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    
    // Set the next date.
    NSString *nextPresentationDate = [self dayMonthYearFormatDate:[NSDate date]];
    [cell.nextDateLabel setText:nextPresentationDate];
    
    // Set the number of questions for the next sets. TODO
    
    // Set the number of question done for this set.
    NSString *questionsCount = [NSString stringWithFormat:@"%d", [[questionSet questionsArray] count]];
    [cell.nextDateQuestionsNumberLabel setText:questionsCount];
    
    // Set the progress for the gauge.
    // float percent = [self questionDonePercentAtIndexPath:indexPath];
    // [cell setGaugeProgress:percent];
    
    // Set the Question Set Title.
    NSString *questionSetTitle = questionSet.title;
    [cell.textLabel setText:questionSetTitle];
}

/**
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"QuestionSetTableViewCell";
    QuestionSetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionSetTableViewCell"
                                                                 owner:self
                                                               options:nil];
        
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[QuestionSetTableViewCell class]]){
                cell = (QuestionSetTableViewCell *) currentObject;
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
    CGFloat detailElementTextHeight = [detailElementText getTextHeightAtFont:ANSWER_CELL_TEXT_FONT_MAJOR_STYLE forWidth:kCellAnswerDefaultTextWidth];
    
    return detailElementTextHeight ;
}

/**
 @brief Return custom height from each row based on each row data and assuming it is a GenericBalanceCell. Else it returns 0.
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat minimumCellHeight = 67;
    CGFloat cellHeight = 0;
    QuestionSet *currentQuestionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    
    cellHeight = kCellQuestionSetTitleOriginMinorY + [self detailElementTextHeight:currentQuestionSet.title] + kCellQuestionSetPaddingY;
    
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
    QuestionTrainingSessionViewController *questionViewController = [[QuestionTrainingSessionViewController alloc] initWithQuestionsArray:questionsArray];
    [self.navigationController pushViewController:questionViewController animated:YES];
    
}


@end
