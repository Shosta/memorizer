//
//  QuestionsListViewController.m
//  Memorizer
//
//  Created by Rems on 02/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionsListViewController.h"
#import "Question.h"
#import "SingleQuestionViewController.h"
#import "QuestionTableViewCell.h"

@interface QuestionsListViewController ()

@end

@implementation QuestionsListViewController


#pragma mark - Object

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           shortTitle:(NSString *)aShortTitle
       questionsArray:(NSMutableArray *)aQuestionSetArray{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.shortTitle = aShortTitle;
    self.questionsArray = aQuestionSetArray;
  }
  
  return self;
}

- (id)initWithShortTitle:(NSString *)aShortTitle
          questionsArray:(NSMutableArray *)aQuestionSetArray{
  return [self initWithNibName:@"QuestionsListViewController" bundle:nil shortTitle:aShortTitle questionsArray:aQuestionSetArray];
}


#pragma mark - View

- (void)viewDidLoad{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
  [self.view setBackgroundColor:color];
  
  [self.navigationItem setTitle:self.shortTitle];
}


#pragma mark - Cell Count

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView{
  int sectionCount = 1;
  
  return sectionCount;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
  int rowsInSection = [self.questionsArray count];
  
  return rowsInSection;
}


#pragma mark - Cell

- (void)configureCell:(QuestionTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
  Question *currentQuestion = [self.questionsArray objectAtIndex:indexPath.row];
  [cell.statementLabel setText:currentQuestion.statement];
  [cell.answerLabel setText:currentQuestion.answer];
  
  NSMutableString *imageName = [NSMutableString stringWithString:@"level"];
  MemorizationLevel memorizationLevel = currentQuestion.userLastMemorizationLevel;
  switch (memorizationLevel) {
    case MemorizationLevel1:
      [imageName appendString:@"1.png"];
      break;
      
    case MemorizationLevel2:
      [imageName appendString:@"2.png"];
      break;
      
    case MemorizationLevel3:
      [imageName appendString:@"3.png"];
      break;
      
    case MemorizationLevel4:
      [imageName appendString:@"4.png"];
      break;
      
    case MemorizationLevel5:
      [imageName appendString:@"5.png"];
      break;
      
    default:
      break;
  }
  [cell.memorizationLevelImageView setImage:[UIImage imageNamed:imageName]];
}

/**
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSString *CellIdentifier = @"QuestionTableViewCell";
  QuestionTableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionTableViewCell"
                                                             owner:self
                                                           options:nil];
    
    for(id currentObject in topLevelObjects){
      if([currentObject isKindOfClass:[QuestionTableViewCell class]]){
        cell = (QuestionTableViewCell *) currentObject;
        
        break;
      }
    }
    
  }
  // [cell.backgroundView setBackgroundColor:CELL_BACKGROUND_COLOR];
  [cell setBackgroundColor:[UIColor darkGrayColor]];
  [self configureCell:cell atIndexPath:indexPath];
  
  return cell;
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
  
  Question *currentQuestion = [self.questionsArray objectAtIndex:indexPath.row];
  NSMutableArray *questionsArray = [NSArray arrayWithObject:currentQuestion];
  SingleQuestionViewController *questionViewController = [[SingleQuestionViewController alloc] initWithQuestionsArray:questionsArray
                                                                                                  shouldDisplayAnswer:YES
                                                                                             shouldDisplayDescription:YES];
  [self.navigationController pushViewController:questionViewController animated:YES];
}


#pragma mark - Footer

/**
 @brief Remove extra separator lines for empty rows and display a shadow effect.
 @author : Rémi Lavedrine
 @date : 29/05/2013
 @remarks : <#(optional)#>
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  UIImageView *footerShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow.png"]];

  return footerShadowView;
}


@end
