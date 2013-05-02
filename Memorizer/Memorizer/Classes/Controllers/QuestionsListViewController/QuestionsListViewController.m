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

@interface QuestionsListViewController ()

@end

@implementation QuestionsListViewController


#pragma mark - Object

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       questionsArray:(NSMutableArray *)aQuestionSetArray{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.questionsArray = aQuestionSetArray;
    }
    
    return self;
}

- (id)initWithQuestionsArray:(NSMutableArray *)aQuestionSetArray{
    return [self initWithNibName:@"QuestionsListViewController" bundle:nil questionsArray:aQuestionSetArray];
}


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
    int rowsInSection = [self.questionsArray count];
    
    return rowsInSection;
}


#pragma mark - Cell

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    Question *currentQuestion = [self.questionsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:currentQuestion.statement];
}

/**
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : ;
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"QuestionSetTableViewCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
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
    SingleQuestionViewController *questionViewController = [[SingleQuestionViewController alloc] initWithQuestionsArray:questionsArray];
    [self.navigationController pushViewController:questionViewController animated:YES];
}


@end
