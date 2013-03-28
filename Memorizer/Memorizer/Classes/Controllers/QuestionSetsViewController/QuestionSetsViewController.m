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
 @brief Create the cells that describes the user data plan and the one that allows the user to add some options or so one.
 @author : Rémi Lavedrine
 @date : 05/07/2012
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"QuestionSetCellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    NSString *questionSetTitle = questionSet.title;
    [cell.textLabel setText:questionSetTitle];
    
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
    QuestionSet *questionSet = [[APP_DATA questionSetsArray] objectAtIndex:indexPath.row];
    QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestionSet:questionSet.questionsArray];
    [self.navigationController pushViewController:questionViewController animated:YES];
}


@end
