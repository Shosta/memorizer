//
//  QuestionViewController.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionViewController.h"
#import "NSString+LabelSize.h"
#import "Question.h"
#import "AnswerTableViewCell.h"
#import "DescriptionTableViewCell.h"

@interface QuestionViewController ()

@property (nonatomic, retain) NSMutableArray *questionSetArray;
@property int currentQuestionIndex;
@property BOOL isAnswerRequired;
@property BOOL isDescriptionRequired;

@property (nonatomic, retain) UIButton *nextQuestionButton;
@end

@implementation QuestionViewController


static const int kStatementSection = 0;
static const int kAnswerSection = 1;
static const int kDescriptionSection = 2;


#pragma mark - Object

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
          questionSet:(NSMutableArray *)aQuestionSetArray{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.questionSetArray = aQuestionSetArray;
    self.currentQuestionIndex = 0;
    self.isAnswerRequired = NO;
    self.isDescriptionRequired = NO;
  }
  
  return self;
}

- (id)initWithQuestionSet:(NSMutableArray *)aQuestionSetArray{
  return [self initWithNibName:@"QuestionViewController" bundle:nil questionSet:aQuestionSetArray];
}


#pragma mark - NextQuestion

- (void)displayNextQuestion{
  if (self.currentQuestionIndex + 1 < [self.questionSetArray count]){ // As arrays starts at "0" in Objective-C.
    // 1. Change the question index.
    self.currentQuestionIndex = self.currentQuestionIndex + 1;
    
    // 2. Remove answer an description.
    self.isAnswerRequired = NO;
    self.isDescriptionRequired = NO;
    
    // 3. Reload the tableView with the new question.
    [self.tableView reloadData];
    
    // 4. Change the NavigationBar title.
    [self setNavigationBarTitle];
  }
}


#pragma mark - Navigation title

- (void)setNavigationBarTitle{
  int index = self.currentQuestionIndex + 1; // As arrays starts at "0" in Objective-C.
  int questionsCount  = [self.questionSetArray count];
  
  NSString *title = [NSString stringWithFormat:@"Question %d sur %d", index, questionsCount];
  [self.navigationItem setTitle:title];
}

- (void)setNavigationBarNextQuestionButton{
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
  // Do any additional setup after loading the view from its nib.
  [self setNavigationBarTitle];
  [self setNavigationBarNextQuestionButton];
}


#pragma mark - Cell Count

/**
 @brief The number of sections in the TableView
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : There are three sections.
 0. The question statement
 1. The answer
 2. The description (something to go further to explain the answer).
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
  int sectionCount = 2;
  
  int descriptionRowCount = 0;
  if (self.isDescriptionRequired) {
    descriptionRowCount = 1;
  }
  
  return sectionCount + descriptionRowCount;
}

/**
 @brief The number of row in the section
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : There is always 1 row per section.
 */
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
  int rowsInSection = 1;
  
  return rowsInSection;
}


#pragma mark - Statement Cell

- (UITableViewCell *)statementCell:(UITableView *)aTableView{
  NSString *cellIdentifier = @"StatementCellIdentifier";
  UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setUserInteractionEnabled:NO];
  }
  Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
  NSString *statement = currentQuestion.statement;
  [cell.textLabel setText:statement];
  
  return cell;
}


#pragma mark - Answer Cell

- (UITableViewCell *)answerCell:(UITableView *)aTableView{
  NSString *CellIdentifier = @"AnswerTableViewCell";
  AnswerTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AnswerTableViewCell"
                                                             owner:self
                                                           options:nil];
    
    for(id currentObject in topLevelObjects){
      if([currentObject isKindOfClass:[AnswerTableViewCell class]]){
        cell = (AnswerTableViewCell *) currentObject;
        break;
      }
    }
  }
  
  if (self.isAnswerRequired == YES) {
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
    NSString *answer = currentQuestion.answer;
    [cell.textLabel setText:answer];
  }else{
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [cell.textLabel setText:@"Réponse"];
  }
  
  return cell;
}


#pragma mark - Description Cell

- (UITableViewCell *)descriptionCell:(UITableView *)aTableView{
  NSString *CellIdentifier = @"DescriptionCellIdentifier";
  DescriptionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DescriptionTableViewCell"
                                                             owner:self
                                                           options:nil];
    
    for(id currentObject in topLevelObjects){
      if([currentObject isKindOfClass:[DescriptionTableViewCell class]]){
        cell = (DescriptionTableViewCell *) currentObject;
        break;
      }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  if (self.isDescriptionRequired == YES) {
    Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
    NSString *description = currentQuestion.description;
    [cell.textLabel setText:description];
  }
  
  return cell;
}


#pragma mark - Generic

/**
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = nil;
  
  switch (indexPath.section) {
    case kStatementSection:
      cell = [self statementCell:aTableView];
      break;
      
    case kAnswerSection:
      cell = [self answerCell:aTableView];
      break;
      
    case kDescriptionSection:
      cell = [self descriptionCell:aTableView];
      break;
      
    default:
      break;
  }
  
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

#define TEXTUAL_CELL_DETAIL_ELEMENT_TEXT_LABEL_START_Y 51
#define GRAPHICAL_CELL_DETAIL_ELEMENT_TEXT_LABEL_START_Y 89
#define CELL_PADDING_Y 10
/**
 @brief Return custom height from each row based on each row data and assuming it is a GenericBalanceCell. Else it returns 0.
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  CGFloat minimumCellHeight = 44;
  CGFloat cellHeight = 0;
  Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
  
  int index = indexPath.section;
  switch (index) {
    case kStatementSection:
      cellHeight = kCellAnswerPaddingY + [self detailElementTextHeight:currentQuestion.statement] + kCellAnswerPaddingY;
      break;
      
    case kAnswerSection:
      cellHeight = kCellAnswerPaddingY + [self detailElementTextHeight:currentQuestion.answer] + kCellAnswerPaddingY;
      break;
      
    case kDescriptionSection:
      cellHeight = kCellAnswerPaddingY + [self detailElementTextHeight:currentQuestion.description] + kCellAnswerPaddingY;
      break;
      
    default:
      break;
  }
  if (cellHeight < minimumCellHeight) {
    cellHeight = minimumCellHeight;
  }
  
  return cellHeight;
}


#pragma mark - Selection

- (void)displayAnswer{
  if (!self.isAnswerRequired) {
    self.isAnswerRequired = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void)displayDescription{
  if (self.isAnswerRequired && !self.isDescriptionRequired) {
    self.isDescriptionRequired = YES;
    [self.tableView reloadData];
  }
}

/**
 @brief It displays the details for the selected part of the user's balance.
 @author : Rémi Lavedrine
 @date : 27/08/2012
 @remarks : <#(optional)#>
 */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  switch (indexPath.section) {
    case 1:
      [self displayDescription];
      [self displayAnswer];
      break;
      
    default:
      break;
  }
}



@end
