//
//  QuestionSetsViewController.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetsViewController.h"
#import "AppData.h"
#import "QuestionSet.h"
#import "QuestionViewController.h"
#import "QuestionSetTableViewCell.h"
#import "NSString+LabelSize.h"
#import "NSDateFormatter+Date.h"

@interface QuestionSetsViewController ()

@end

@implementation QuestionSetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
  [self.view setBackgroundColor:color];
  
  [self.navigationItem setTitle:@"Ultimemo"];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Cell Count

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
  int sectionCount = 1;
  
  return sectionCount;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
  int rowsInSection = [[APP_DATA questionSetsArray] count];
  
  return rowsInSection;
}


#pragma mark - Generic

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

- (void)configureCell:(QuestionSetTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
  QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
  
  // Set the next date.
  NSDate *today = [NSDate date];
  NSString *todayDate = [self dayMonthYearFormatDate:today];
  [cell.nextDateLabel setText:todayDate];
  
  // Set the number of questions for the next sets. TODO
  
  // Set the number of question done for this set.
  NSString *questionDoneCount = [NSString stringWithFormat:@"x/%d", [questionSet.questionsArray count]];
  [cell.nextQuestionsNumberLabel setText:questionDoneCount];
  
  // Set the progress for the gauge.
  [cell setGaugeProgress:0.75];
  
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
  CGFloat detailElementTextHeight = [detailElementText getTextHeightAtFont:ANSWER_CELL_TEXT_FONT forWidth:kCellAnswerDefaultTextWidth];
  
  return detailElementTextHeight ;
}

/**
 @brief Return custom height from each row based on each row data and assuming it is a GenericBalanceCell. Else it returns 0.
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  CGFloat minimumCellHeight = 162;
  CGFloat cellHeight = 0;
  QuestionSet *currentQuestionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
  
  cellHeight = kCellAnswerPaddingY + [self detailElementTextHeight:currentQuestionSet.title] + kCellAnswerPaddingY;
  
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
  
  QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
  QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestionSet:questionSet.questionsArray];
  [self.navigationController pushViewController:questionViewController animated:YES];
}


@end
