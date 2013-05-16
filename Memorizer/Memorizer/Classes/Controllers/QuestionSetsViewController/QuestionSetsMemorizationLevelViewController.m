//
//  QuestionSetsViewController.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetsMemorizationLevelViewController.h"
#import "AppData.h"
#import "QuestionSet.h"
#import "Question.h"
#import "NextPresentationQuestionSet.h"
#import "QuestionMemorizationLevelViewController.h"
#import "QuestionSetTableViewCell.h"
#import "NSString+LabelSize.h"
#import "NSDateFormatter+Date.h"

@interface QuestionSetsMemorizationLevelViewController ()

@property (nonatomic, retain) NSMutableArray *nextPresentationQuestionSetsArray;
@property (nonatomic, retain) OLStatusView *statusView;

@end

@implementation QuestionSetsMemorizationLevelViewController


#pragma mark - Object

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 12/04/2013
 @remarks : <#(optional)#>
 */
- (void)populateNextPresentationQuestionSetsArray{
  for (QuestionSet *questionSet in [APP_DATA questionSetsArray]) {
    NextPresentationQuestionSet *nextPresentationQuestionSet = [[NextPresentationQuestionSet alloc] initWithQuestionSet:questionSet];
    [self.nextPresentationQuestionSetsArray addObject:nextPresentationQuestionSet];
  }
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self != nil) {
    // Custom initialization
    self.nextPresentationQuestionSetsArray = [[NSMutableArray alloc] initWithCapacity:[[APP_DATA questionSetsArray] count]];
    [self populateNextPresentationQuestionSetsArray];
  }
  
  return self;
}


#pragma mark - Refresh View

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 12/04/2013
 @remarks : <#(optional)#>
 */
- (void)refreshView{
  [self.nextPresentationQuestionSetsArray removeAllObjects];
  [self populateNextPresentationQuestionSetsArray];
  [self.tableView reloadData];
}


#pragma mark - View

- (void)viewDidLoad{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
  [self.view setBackgroundColor:color];
  
  [self.navigationItem setTitle:@"Ultimemo"];
  
  NSString *message = @"Pas de question pour aujourd'hui.\nAttendez quelques jours pour la prochaine série ou bien faites une série juste pour l'entraînement.";
  self.statusView = [[OLStatusView alloc] initWithStatusLabel:message textFont:[UIFont fontWithName:@"Helvetica" size:16] orientation:UIInterfaceOrientationPortrait translationDirection:DownToUp];
  self.statusView.delegate = self;
  
  [self addHelpButtonOnNavigationBar];
}


#pragma mark - Cell Count

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView{
  int sectionCount = 1;
  
  return sectionCount;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
  int rowsInSection = [self.nextPresentationQuestionSetsArray count];
  
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

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 19/04/2013
 @remarks : <#(optional)#>
 */
- (int)remainingQuestionsCountAtIndexPath:(NSIndexPath *)indexPath{
    QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    NSArray *questionArray = [questionSet questionsArray];
    
    int remainingQuestionsCount = 0;
    for (Question *question in questionArray) {
        if (question.userLastMemorizationLevel == NoMemorizationLevel) {
            remainingQuestionsCount = remainingQuestionsCount + 1;
        }
    }
    
    return remainingQuestionsCount;
}

- (void)configureCell:(QuestionSetTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
  NextPresentationQuestionSet *nextPresentationQuestionSet = [self.nextPresentationQuestionSetsArray objectAtIndex:indexPath.row];
  
  // Set the next date.
  NSString *nextPresentationDate = [self dayMonthYearFormatDate:nextPresentationQuestionSet.nextPresentationDate];
  [cell.nextDateLabel setText:nextPresentationDate];
  
    // Set the number of questions for the next sets.
    NSString *nextDateQuestionsCount = [NSString stringWithFormat:@": %d", [[nextPresentationQuestionSet nextPresentationQuestionArray] count]];
    [cell.nextDateQuestionsNumberLabel setText:nextDateQuestionsCount];
   
    // Set the number of question that needs to be seen by the user.
    NSString *remainingQuestionsCount = [NSString stringWithFormat:@": %d", [self remainingQuestionsCountAtIndexPath:indexPath]];
    [cell.remainingQuestionsNumberLabel setText:remainingQuestionsCount];
    
    // Set the number of questions for this QuestionSet.
    QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    NSArray *questionArray = [questionSet questionsArray];
    NSString *allQuestionsCount = [NSString stringWithFormat:@": %d", [questionArray count]];
    [cell.allQuestionsNumberLabel setText:allQuestionsCount];
    
    // Set the progress for the gauge.
    float percent = [self questionDonePercentAtIndexPath:indexPath];
    [cell setGaugeProgress:percent];
  
  // Set the Question Set Title.
  NSString *questionSetTitle = nextPresentationQuestionSet.title;
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
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionSetMemorizationLevelTableViewCell2"
                                                             owner:self
                                                           options:nil];
    
    for(id currentObject in topLevelObjects){
      if([currentObject isKindOfClass:[QuestionSetTableViewCell class]]){
        cell = (QuestionSetTableViewCell *) currentObject;
        break;
      }
    }
    [cell setCellStyle:QuestionSetTableViewCellMajorStyle];
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
  CGFloat minimumCellHeight = 250;
  CGFloat cellHeight = 0;
  NextPresentationQuestionSet *currentQuestionSet = [self.nextPresentationQuestionSetsArray objectAtIndex:indexPath.row];
  
  cellHeight = kCellQuestionSetTitleOriginMajorY + [self detailElementTextHeight:currentQuestionSet.title] + kCellQuestionSetPaddingY;

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
  
  NextPresentationQuestionSet *nextPresentationQuestionSet = [self.nextPresentationQuestionSetsArray objectAtIndex:indexPath.row];
  NSMutableArray *questionsArray = nextPresentationQuestionSet.nextPresentationQuestionArray;
  if ([questionsArray count] > 0) {
    QuestionMemorizationLevelViewController *questionViewController = [[QuestionMemorizationLevelViewController alloc] initWithQuestionsArray:questionsArray];
    
    [self.navigationController pushViewControllerFromRight:questionViewController];
  }else{
    NSString *message = [NSString stringWithFormat:@"Pas de question pour aujourd'hui.\nAttendez le %@ pour la prochaine série ou bien faites une série juste pour l'entraînement.", [self dayMonthYearFormatDate:nextPresentationQuestionSet.nextPresentationDate]];
    OLLogDebug(@"%@", message);
    [self.statusView.statusLabel setText:message];
    [self.statusView popOnView:self.view];
  }
}


@end
