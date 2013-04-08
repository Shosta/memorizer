//
//  QuestionViewController.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"

@interface QuestionViewController ()

@property (nonatomic, retain) NSMutableArray *questionSetArray;
@property int currentQuestionIndex;
@property BOOL isAnswerRequired;
@property BOOL isDescriptionRequired;
@end

@implementation QuestionViewController


#pragma mark - Object

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
          questionSet:(NSMutableArray *)aQuestionSetArray
{
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

- (id)initWithQuestionSet:(NSMutableArray *)aQuestionSetArray
{
    return [self initWithNibName:@"QuestionViewController" bundle:nil questionSet:aQuestionSetArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *cellIdentifier = @"AnswerCellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (self.isAnswerRequired == YES) {
        [cell setUserInteractionEnabled:NO];
        Question *currentQuestion = [self.questionSetArray objectAtIndex:self.currentQuestionIndex];
        NSString *answer = currentQuestion.answer;
        [cell.textLabel setText:answer];
    }else{
        [cell setUserInteractionEnabled:YES];
        [cell.textLabel setText:@"Réponse"];
    }
    
    return cell;
    
    
}

#pragma mark - Description Cell

- (UITableViewCell *)descriptionCell:(UITableView *)aTableView{
    NSString *cellIdentifier = @"DescriptionCellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setUserInteractionEnabled:NO];
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
        case 0:
            cell = [self statementCell:aTableView];
            break;
            
        case 1:
            cell = [self answerCell:aTableView];
            break;
            
        case 2:
            cell = [self descriptionCell:aTableView];
            break;
            
        default:
            break;
    }
    
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
    switch (indexPath.section) {
        case 1:
            self.isAnswerRequired = YES;
            [self.tableView reloadData];
            break;
            
        default:
            break;
    }
}



@end
