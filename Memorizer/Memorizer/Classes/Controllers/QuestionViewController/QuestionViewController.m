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
#import "StatementTableViewCell.h"
#import "AnswerTableViewCell.h"
#import "DescriptionTableViewCell.h"

@interface QuestionViewController ()

@property (nonatomic, retain) NSMutableArray *questionSetArray;
@property int currentQuestionIndex;
@property BOOL shouldDisplayAnswer;
@property BOOL shouldDisplayDescription;

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
    self.shouldDisplayAnswer = NO;
    self.shouldDisplayDescription = NO;
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
    self.shouldDisplayAnswer = NO;
    self.shouldDisplayDescription = NO;
    
    // 3. Reload the tableView with the new question.
    [self.tableView reloadData];
    
    // 4. Change the NavigationBar title.
    [self setNavigationBarTitle];
    
    // 5. As the TableView's height was reduced to present the "noting buttons" it has to be resized to its original size.
    [self increaseTableViewHeight];
  }else{
    [self popViewControllerAsQuestionSetFinished];
  }
}


#pragma mark - NavigationBar

- (void)setNavigationBarTitle{
  int index = self.currentQuestionIndex + 1; // As arrays starts at "0" in Objective-C.
  int questionsCount  = [self.questionSetArray count];
  
  NSString *title = [NSString stringWithFormat:@"Question %d sur %d", index, questionsCount];
  [self.navigationItem setTitle:title];
}

/**
 @brief The User finished his questionSet, its pops back the ViewController.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (void)popViewControllerAsQuestionSetFinished{
  [self.navigationController popToRootViewControllerAnimated:YES];
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
  
  UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
  [self.view setBackgroundColor:color];
  [self.tableView setBackgroundColor:color];
}


#pragma mark - Cell Count

/**
 @brief The number of sections in the TableView
 @author : Rémi Lavedrine
 @date : 09/04/2013
 @remarks : There are three sections.
 0. The question statement
 1. The answer
 2. The description (something to go further to explain the answer).
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
  int sectionCount = 2;
  
  int descriptionRowCount = 0;
  if (self.shouldDisplayDescription) {
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
  int rowsInSection = 2; // There is one row for the information and another one for the cell that describes it.
  
  return rowsInSection;
}


#pragma mark - Statement Cell

- (UITableViewCell *)statementCell:(UITableView *)aTableView{
  NSString *CellIdentifier = @"StatementCellIdentifier";
  StatementTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatementTableViewCell"
                                                             owner:self
                                                           options:nil];
    
    for(id currentObject in topLevelObjects){
      if([currentObject isKindOfClass:[StatementTableViewCell class]]){
        cell = (StatementTableViewCell *) currentObject;
        break;
      }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
  
  if (self.shouldDisplayAnswer == YES) {
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
    NSString *answer = currentQuestion.answer;
    [cell.textLabel setText:answer];
    
    [cell fadeInDescriptionImageView];
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
  
  if (self.shouldDisplayDescription == YES) {
    Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
    NSString *description = currentQuestion.description;
    [cell.textLabel setText:description];
  }
  
  return cell;
}


#pragma mark - Generic

/**
 @brief It's the row that describes the info for the section.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)contentDescriptionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = nil;

  NSString *CellIdentifier = @"CellContentDescriptionCellIdentifier";
  cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setBackgroundColor:[UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:88.0f/255.0f green:107.0f/255.0f blue:114.0f/255.0f alpha:1.0f]];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:13]];
  }
  
  NSString *cellContentDescriptionText = @"";
  switch (indexPath.section) {
    case kStatementSection:
      cellContentDescriptionText = @"L'ÉNONCE DE LA QUESTION";
      break;
      
    case kAnswerSection:
      cellContentDescriptionText = @"LA RÉPONSE";
      break;
      
    case kDescriptionSection:
      cellContentDescriptionText = @"POUR ALLER PLUS LOIN";
      break;
      
    default:
      break;
  }
  
  [cell.textLabel setText:cellContentDescriptionText];
  
  return cell;
}

/**
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = nil;
  
  if (indexPath.row == 0) {
    // It's the row that describes the info for the section.
    cell = [self contentDescriptionCellForRowAtIndexPath:indexPath];
    
  } else if (indexPath.row == 1) {
    // It's the row that has the info for the section.
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
    
    [cell.textLabel setTextColor:[UIColor colorWithRed:190/255 green:190/255 blue:190/255 alpha:1.0]];
    
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

/**
 @brief Return custom height from each row based on each row data and assuming it is a GenericBalanceCell. Else it returns 0.
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^)
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  CGFloat cellHeight = 0;
  if (indexPath.row == 0) {
    cellHeight = 30;
  }else{
    CGFloat minimumCellHeight = 44;
    Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
  
  int index = indexPath.section;
  switch (index) {
    case kStatementSection:
      cellHeight = kCellStatementPaddingY + [self detailElementTextHeight:currentQuestion.statement] + kCellStatementPaddingY;
      break;
      
    case kAnswerSection:
      cellHeight = kCellAnswerPaddingY + [self detailElementTextHeight:currentQuestion.answer] + kCellAnswerPaddingY;
      break;
      
    case kDescriptionSection:
      cellHeight = kCellDescriptionPaddingY + [self detailElementTextHeight:currentQuestion.description] + kCellDescriptionPaddingY;
      break;
      
    default:
      break;
  }
  if (cellHeight < minimumCellHeight) {
    cellHeight = minimumCellHeight;
  }
}
  return cellHeight;
}


#pragma mark - Animation

- (void)reduceTableViewHeight{
  @try {
    self.tableView.contentMode = UIViewContentModeRedraw;
    [UIView animateWithDuration:.4f animations:^{
      CGRect theBounds = self.tableView.bounds;
      CGPoint theCenter = self.tableView.center;
      theBounds.size.height -= 64.f;
      theCenter.y -= 32.f;
      self.tableView.bounds = theBounds;
      self.tableView.center = theCenter;
    }];
    
  }
  @catch (NSException *exception) {
    OLLogDebug(@"%@", exception.reason);
  }
  @finally {
    
  }
}

- (void)increaseTableViewHeight{
  @try {
    self.tableView.contentMode = UIViewContentModeRedraw;
    [UIView animateWithDuration:.4f animations:^{
      CGRect theBounds = self.tableView.bounds;
      CGPoint theCenter = self.tableView.center;
      theBounds.size.height += 64.f;
      theCenter.y += 32.f;
      self.tableView.bounds = theBounds;
      self.tableView.center = theCenter;
    }];
    
  }
  @catch (NSException *exception) {
    OLLogDebug(@"%@", exception.reason);
  }
  @finally {
    
  }
}


#pragma mark - Selection

- (void)displayAnswer{
  if (!self.shouldDisplayAnswer) {
    [self reduceTableViewHeight];
    
    self.shouldDisplayAnswer = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
    
  }
}

- (void)displayDescription{
  if (self.shouldDisplayAnswer && !self.shouldDisplayDescription) {
    self.shouldDisplayDescription = YES;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:kDescriptionSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
  }
}

/**
 @brief It displays the details for the selected part of the user's balance.
 @author : Rémi Lavedrine
 @date : 27/08/2012
 @remarks : <#(optional)#>
 */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row == 1) {
    switch (indexPath.section) {
      case kAnswerSection:
        [self displayDescription];
        [self displayAnswer];
        break;
        
      default:
        break;
    }
  }
}


#pragma mark - Footer

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
  NSString *footerTitle = @"";
  switch (section) {
    case kAnswerSection:
      if (!self.shouldDisplayDescription) {
        if (!self.shouldDisplayAnswer) {
          footerTitle = @"Visualisez la réponse et appuyez sur \"Réponse\".";
        }else{
          footerTitle = @"Appuyez sur la flèche si vous voulez en savoir plus.";
        }
      }
      break;
      
      case kDescriptionSection:
        if (self.shouldDisplayDescription) {
          footerTitle = @"Choisissez ci-dessous la valeur qui vous semble le plus à même de représenter votre niveau de mémorisation de cette question.";
      }
      break;
      
    default:
      break;
  }
  
  return footerTitle;
}



@end
