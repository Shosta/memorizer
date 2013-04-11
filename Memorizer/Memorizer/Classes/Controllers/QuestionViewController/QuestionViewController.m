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
    self.shouldDisplayAnswer = [NSNumber numberWithBool:NO];
    self.shouldDisplayDescription = [NSNumber numberWithBool:NO];
  }
  
  return self;
}

- (id)initWithQuestionSet:(NSMutableArray *)aQuestionSetArray{
  return [self initWithNibName:@"QuestionViewController" bundle:nil questionSet:aQuestionSetArray];
}


#pragma mark - KVO

- (void)registerForKVO {
	for (NSString *keyPath in [self observableKeypaths]) {
		[self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
	}
}

- (void)unregisterFromKVO {
	for (NSString *keyPath in [self observableKeypaths]) {
		[self removeObserver:self forKeyPath:keyPath];
	}
}

- (NSArray *)observableKeypaths {
	return [NSArray arrayWithObjects:kShouldDisplayAnswerKey, kShouldDisplayDescriptionKey, nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (![NSThread isMainThread]) {
		[self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
	} else {
		[self updateUIForKeypath:keyPath];
	}
}

- (void)updateUIForKeypath:(NSString *)keyPath {
  if ([keyPath isEqualToString:kShouldDisplayAnswerKey]) {
    if ([self.shouldDisplayAnswer boolValue] == YES && [self.shouldDisplayDescription boolValue] == NO) {
      // To display the Answer and change the Footer's title.
      [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
    }
	}
  
  if ([keyPath isEqualToString:kShouldDisplayDescriptionKey]) {
    [self.tableView reloadData];
    // To display the Answer and change the Footer's title.
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:kAnswerSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
}


#pragma mark - NextQuestion

/**
 @brief Display the next Question on Screen.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : It removes all the question, answer and description from the previous Question. It loads the next one from the questionArray.
 It sets the navigationBar title to mention the question's number.
 If it's the last question from the QuestionSet, it pops to the RootViewController.
 */
- (void)displayNextQuestion{
  if (self.currentQuestionIndex + 1 < [self.questionSetArray count]){ // As arrays starts at "0" in Objective-C.
                                                                      // 1. Change the question index.
    self.currentQuestionIndex = self.currentQuestionIndex + 1;
    
    // 2. Remove answer an description.
    self.shouldDisplayAnswer = [NSNumber numberWithBool:NO];
    self.shouldDisplayDescription = [NSNumber numberWithBool:NO];
    
    // 3. Reload the tableView with the new question.
    [self.tableView reloadData];
    
    // 4. Change the NavigationBar title.
    [self setNavigationBarTitle];
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
  [self registerForKVO];
  
  [self setNavigationBarTitle];
  [self setNavigationBarNextQuestionButton];
  
  UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
  [self.view setBackgroundColor:color];
  [self.tableView setBackgroundColor:color];
}

- (void)viewDidUnload{
  [super viewDidUnload];
  
  [self unregisterFromKVO];
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
  if ([self.shouldDisplayDescription boolValue]) {
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
  
  if ([self.shouldDisplayAnswer boolValue] == YES) {
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
  
  if ([self.shouldDisplayDescription boolValue] == YES) {
    Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
    NSString *description = currentQuestion.description;
    [cell.textLabel setText:description];
  }
  
  return cell;
}


#pragma mark - Generic Cell

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
 @brief It's the row about the content for the section.
 @author : Rémi Lavedrine
 @date : 11/04/2013
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView infoDescriptionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = nil;
  
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
    cell = [self tableView:aTableView infoDescriptionCellForRowAtIndexPath:indexPath];
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


#pragma mark - Selection

/**
 @brief Display the Answer when the user taps the cell.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : It reloads only the "kAnswerSection" section to avoid unnecessary redraw.
 */
- (void)displayAnswer{
  if ([self.shouldDisplayAnswer boolValue] == NO) {
    [self setShouldDisplayAnswer:[NSNumber numberWithBool:YES]];
    // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
  }
}

/**
 @brief Display the Description when the user taps the cell.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : It reloads the all TableView because the "kDescriptionSection" is not yet created it can't be redrawn.
 When it's been drawn, we scroll to the Answer's cell (the first row of the "kAnswerSection" section).
 */
- (void)displayDescription{
  if ([self.shouldDisplayAnswer boolValue] == YES && [self.shouldDisplayDescription boolValue] == NO) {
    self.shouldDisplayDescription = [NSNumber numberWithBool:YES];
    // [self.tableView reloadData];
    // [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:kAnswerSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
  }
}

/**
 @brief It displays the details for the selected part of the user's balance.
 @author : Rémi Lavedrine
 @date : 27/08/2012
 @remarks : <#(optional)#>
 */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [aTableView deselectRowAtIndexPath:indexPath animated:YES];
  
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
      if ([self.shouldDisplayDescription boolValue] == NO) {
        if ([self.shouldDisplayAnswer boolValue] == NO) {
          footerTitle = @"Visualisez la réponse et appuyez sur \"Réponse\".";
        }else{
          footerTitle = @"Appuyez sur la flèche si vous voulez en savoir plus.";
        }
      }
      break;
      
    default:
      break;
  }
  
  return footerTitle;
}



@end
