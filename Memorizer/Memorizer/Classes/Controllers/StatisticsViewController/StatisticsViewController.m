//
//  StatisticsViewController.m
//  Memorizer
//
//  Created by Rems on 03/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "StatisticsViewController.h"
#import "MemorizationCardLevelNumberCell.h"
#import "MemorizationCardToReviseNumberCell.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController


#pragma mark - Object

- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet{
    self = [super initWithNibName:@"StatisticsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        self.questionSet = aQuestionSet;
        self.cardMemorizationLevelStatistics = [[CardMemorizationLevelStatistics alloc] initWithQuestionsArray:aQuestionSet.questionsArray];
        self.cardToReviseNumberStatistics = [[CardToReviseNumberStatistics alloc] initWithQuestionsArray:aQuestionSet.questionsArray];
    }
    
    return self;
}


#pragma mark - View

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackgroundTemplateColor.png"]];
    [self.view setBackgroundColor:color];
    [self.statisticsTableView setBackgroundColor:color];
    
    self.navigationItem.title = self.questionSet.title;
}


#pragma mark - Cell Count

/**
 @brief The number of sections in the TableView
 @author : Rémi Lavedrine
 @date : 03/05/2013
 @remarks : <#(optional)#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    int sectionCount = 1;
    
    return sectionCount;
}

/**
 @brief The number of row in the section
 @author : Rémi Lavedrine
 @date : 03/05/2013
 @remarks : There is one row for the number of cards for each memorization level and another one for the cell that describes the number of cards to revise for the next days.
 */
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
    int rowsInSection = 2; // There is one row for the number of cards for each memorization level and another one for the cell that describes the number of cards to revise for the next days.
    
    return rowsInSection;
}


#pragma mark - MemorizationCardLevelNumber

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 03/05/2013
 @remarks : <#(optional)#>
 */
-(MemorizationCardLevelNumberCell *)memorizationCardLevelNumberCell{
    NSString *CellIdentifier = @"MemorizationCardLevelNumberCellIdentifier";
    MemorizationCardLevelNumberCell *cell = [self.statisticsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MemorizationCardLevelNumberCell"
                                                                 owner:self
                                                               options:nil];
        
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[MemorizationCardLevelNumberCell class]]){
                cell = (MemorizationCardLevelNumberCell *) currentObject;
                break;
            }
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    // Configure Cell
    [cell.cardTotalCount setText:[NSString stringWithFormat:@"Total : %d", self.questionSet.questionsArray.count]];
    [cell.level1CardSatistiscs setText:[NSString stringWithFormat:@"(%0.0f%%) %0.0f", self.cardMemorizationLevelStatistics.level1Percent, self.cardMemorizationLevelStatistics.level1Number]];
    [cell.level2CardSatistiscs setText:[NSString stringWithFormat:@"(%0.0f%%) %0.0f", self.cardMemorizationLevelStatistics.level2Percent, self.cardMemorizationLevelStatistics.level2Number]];
    [cell.level3CardSatistiscs setText:[NSString stringWithFormat:@"(%0.0f%%) %0.0f", self.cardMemorizationLevelStatistics.level3Percent, self.cardMemorizationLevelStatistics.level3Number]];
    [cell.level4CardSatistiscs setText:[NSString stringWithFormat:@"(%0.0f%%) %0.0f", self.cardMemorizationLevelStatistics.level4Percent, self.cardMemorizationLevelStatistics.level4Number]];
    [cell.level5CardSatistiscs setText:[NSString stringWithFormat:@"(%0.0f%%) %0.0f", self.cardMemorizationLevelStatistics.level5Percent, self.cardMemorizationLevelStatistics.level5Number]];

    return cell;
}


#pragma mark - MemorizationCardToReviseNumber

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 03/05/2013
 @remarks : <#(optional)#>
 */
-(MemorizationCardToReviseNumberCell *)memorizationCardToReviseNumberCell{
    NSString *CellIdentifier = @"MemorizationCardToReviseNumberCellIdentifier";
    MemorizationCardToReviseNumberCell *cell = [self.statisticsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MemorizationCardToReviseNumberCell"
                                                                 owner:self
                                                               options:nil];
        
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[MemorizationCardToReviseNumberCell class]]){
                cell = (MemorizationCardToReviseNumberCell *) currentObject;
                break;
            }
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell.cardNumberTodayLabel setText:[NSString stringWithFormat:@"%d", self.cardToReviseNumberStatistics.cardNumberToday]];
    [cell.cardNumberTomorrowLabel setText:[NSString stringWithFormat:@"%d", self.cardToReviseNumberStatistics.cardNumberTomorrow]];
    [cell.cardNumberInTwoDaysLabel setText:[NSString stringWithFormat:@"%d", self.cardToReviseNumberStatistics.cardNumberInTwoDays]];
    [cell.cardNumberInThreeDaysLabel setText:[NSString stringWithFormat:@"%d", self.cardToReviseNumberStatistics.cardNumberInThreeDays]];
    [cell.cardNumberInFourDaysLabel setText:[NSString stringWithFormat:@"%d", self.cardToReviseNumberStatistics.cardNumberInFourDays]];

    return cell;
}


#pragma mark - Cell

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 03/05/2013
 @remarks : <#(optional)#>
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        // It's the row that describes the info for the section.
        cell = [self memorizationCardLevelNumberCell];
        
    } else if (indexPath.row == 1) {
        cell = [self memorizationCardToReviseNumberCell];
    }
    
    return cell;
}


#pragma mark - Height

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 03/05/2013
 @remarks : <#(optional)#>
 */
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 257;
    
    if (indexPath.row == 0) {
        // It's the row that describes the info for the section.
        cellHeight = 257;
        
    } else if (indexPath.row == 1) {
        cellHeight = 193;
    }
        
    return cellHeight;
}


@end
