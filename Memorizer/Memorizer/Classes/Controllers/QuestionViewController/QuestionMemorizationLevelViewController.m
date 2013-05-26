//
//  QuestionMemorizationLevelViewController.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 11/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionMemorizationLevelViewController.h"
#import "Question.h"
#import "QuestionSetsMemorizationLevelViewController.h"
#import "AppDelegate.h"

@implementation QuestionMemorizationLevelViewController

static const int kStatementSection = 0;
static const int kAnswerSection = 1;
static const int kDescriptionSection = 2;

#pragma mark - Help View

/**
 @brief Add the help view on top of the current view.
 @author : Rémi Lavedrine
 @date : 10/09/2012
 @remarks : <#(optional)#>
 */
- (IBAction)addHelpSubview{
    NSString *helpImageName = @"QuestionHelpImage@2x.png";
    if ([self.shouldDisplayAnswer boolValue] == YES) {
        [self.helpImageContainerScrollView setContentSize:CGSizeMake(320, 940)];
        [self.helpImageView setFrame:CGRectMake(0, 0, 320, 940)];
        helpImageName = @"QuestionAnsweredHelpImage@2x.png";
    }else{
        [self.helpImageContainerScrollView setContentSize:CGSizeMake(320, 367)];
        [self.helpImageView setFrame:CGRectMake(0, 0, 320, 367)];
    }
    [self.helpImageView setImage:[UIImage imageNamed:helpImageName]];
    
    [super addHelpSubview];
}

/**
 @brief Display the Help View for the Statement if it's the first launch.
 @author : Rémi Lavedrine
 @date : 26/05/2013
 @remarks : <#(optional)#>
 */
- (void)displayStatementHelpImageOnFirstLaunch{
    NSNumber *isFirstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:kIsQuestionStatementHelpAlreadyDisplayedKey];
    
    if ([isFirstLaunch boolValue] == NO) {
        [self addHelpSubview];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:kIsQuestionStatementHelpAlreadyDisplayedKey];
    }
}

/**
 @brief Display the Help View for the Answer if it's the first launch.
 @author : Rémi Lavedrine
 @date : 26/05/2013
 @remarks : <#(optional)#>
 */
- (void)displayAnswerHelpImageOnFirstLaunch{
    NSNumber *isFirstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:kIsQuestionAnswerHelpAlreadyDisplayedKey];
    
    if ([isFirstLaunch boolValue] == NO) {
        [self addHelpSubview];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:kIsQuestionAnswerHelpAlreadyDisplayedKey];
    }
}


#pragma mark - Object

- (id)initWithQuestionsArray:(NSMutableArray *)aQuestionsArray{
    self = [super initWithNibName:@"QuestionMemorizationLevelViewController" bundle:nil questionsArray:aQuestionsArray];
    if (self != nil) {
        self.isMemorizationLevelChosen = [NSNumber numberWithBool:NO];
        self.shouldDisplayNextQuestion = [NSNumber numberWithBool:NO];
    }
    
    return self;
}


#pragma mark - NavigationBar

- (void)addNavigationBarNextQuestionButton{
    // Do nothing.
    // TODO Need to subclass the QuestionViewController and add only the “addNavigationBarNextQuestionButton“ to the class. Add the nextQuestionButton only to the QuestionViewController child class.
}


#pragma mark - View

/**
 @brief Don't allow interaction on "nextQuestionButton" as the user needs to choose a memorization level on this kind of ViewController.
 @author : Rémi Lavedrine
 @date : 12/04/2013
 @remarks : <#(optional)#>
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.nextQuestionButton setUserInteractionEnabled:NO];
  [self addHelpButtonOnNavigationBar];
    
    [self displayStatementHelpImageOnFirstLaunch];
}


#pragma mark - KVO

static NSString *kIsMemorizationLevelChosenKey = @"isMemorizationLevelChosen";

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
	return [NSArray arrayWithObjects:kIsMemorizationLevelChosenKey, kShouldDisplayAnswerKey, kShouldDisplayDescriptionKey, nil];
}

/**
 @brief
 @author : Rémi Lavedrine
 @date : 11/04/2013
 @remarks :
 . Display the Answer when the user taps the cell.
 It reloads only the "kAnswerSection" section to avoid unnecessary redraw.
 It reduces the TableView height to make the "Memorizatoin level buttons" available.
 */
- (void)updateUIForKeypath:(NSString *)keyPath {
    [super updateUIForKeypath:keyPath];
    
    if ([keyPath isEqualToString:kIsMemorizationLevelChosenKey]){
        if ([self.isMemorizationLevelChosen boolValue] == YES){
            [self.nextQuestionButton setUserInteractionEnabled:YES];
            
            if ([self.shouldDisplayDescription boolValue] == YES){
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kDescriptionSection] withRowAnimation:UITableViewRowAnimationFade];
                
            }else if ([self.shouldDisplayAnswer boolValue] == YES){
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
                
            }
        }else{
            [self.nextQuestionButton setUserInteractionEnabled:NO];
            
        }
    }
    
    if ([keyPath isEqualToString:kShouldDisplayAnswerKey]) {
        if ([self.shouldDisplayAnswer boolValue] == YES && [self.shouldDisplayDescription boolValue] == NO) {
            [self reduceTableViewHeight];
            [self displayAnswerHelpImageOnFirstLaunch];
        }
	}
}


#pragma mark - NextQuestion

/**
 @brief Pop the QuestionSetsViewController as the Questions list is finished.
 @author : Rémi Lavedrine
 @date : 12/04/2013
 @remarks : It refresh the QuestionSetsViewController's TableView as well.
 */
- (void)popQuestionSetsViewController{
    [super popQuestionSetsViewController];
    
    UITabBarController *tabBarController = [APP_DELEGATE tabBarController];
    NSArray *tabBarViewControllers = [tabBarController viewControllers];
    UINavigationController *navController = [tabBarViewControllers objectAtIndex:0];
    NSArray *navViewControllers = [navController viewControllers];
    
    QuestionSetsMemorizationLevelViewController *rootViewController = [navViewControllers objectAtIndex:navViewControllers.count - 1];
    [rootViewController refreshView];
}

- (void)addDaysToQuestion:(Question *)currentQuestion accordingTo:(MemorizationLevel)aMemorizationLevel{
  int daysToAdd = 0;
  
  switch (aMemorizationLevel) {
    case MemorizationLevel1:
      // On est dans la phase d'acquisition, on remet la question à la fin de la liste pour que l'utilisteur la revoie encore une fois.
      [self.questionsArray addObject:currentQuestion];
      break;
      
    case MemorizationLevel2:
      // On est dans la phase d'acquisition, on remet la question à la fin de la liste pour que l'utilisteur la revoie encore une fois.
      daysToAdd = [currentQuestion daysToAddAccordingTo:MemorizationLevel2];
      break;
      
    case MemorizationLevel3:
      // On est dans la phase d'acquisition, on remet la question à la fin de la liste pour que l'utilisteur la revoie encore une fois.
      daysToAdd = [currentQuestion daysToAddAccordingTo:MemorizationLevel3];
      break;
      
    case MemorizationLevel4:
      daysToAdd = [currentQuestion daysToAddAccordingTo:MemorizationLevel4];
      break;
      
    case MemorizationLevel5:
      daysToAdd = [currentQuestion daysToAddAccordingTo:MemorizationLevel5];
      break;
      
    default:
      break;
  }
  currentQuestion = [self.questionsArray objectAtIndex:self.currentQuestionIndex];
  [currentQuestion setUserLastMemorizationLevel:aMemorizationLevel];
  
  // Set up date components
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setDay:daysToAdd];
  
  // Create a calendar
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
  NSDate *nextPresentationDate = [gregorian dateByAddingComponents:components toDate:currentQuestion.nextPresentationDate options:0];
  OLLogDebug(@"Question : %@;\nCurrent Presentation Date : %@;\nDays to add : %d;\nNext presentation date: %@", currentQuestion.statement, currentQuestion.nextPresentationDate, daysToAdd, nextPresentationDate);
  currentQuestion.nextPresentationDate = nextPresentationDate;
}

/**
 @brief Display the next Question on Screen.
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : It removes all the question, answer and description from the previous Question. It loads the next one from the questionArray.
 It sets the navigationBar title to mention the question's number.
 If it's the last question from the QuestionSet, it pops to the RootViewController.
 */
- (void)displayNextQuestion{
    if ([self.shouldDisplayNextQuestion boolValue] == YES && self.currentQuestionIndex < [self.questionsArray count]){
      Question *currentQuestion = [self.questionsArray objectAtIndex:self.currentQuestionIndex];
      currentQuestion.numberOfRepetition += 1;
      [self addDaysToQuestion:currentQuestion accordingTo:self.memorizationLevel];
      
      [super displayNextQuestion];
    
        // 1. Remove the MemorizationLevelFeedback label.
        [self hideMemorizationLevelSummaryContainerView];
        
        // 2. Reset the button state to unselected.
        [self removePreviousSelectedStateToButton];
        // 3. As the TableView's height was reduced to present the "noting buttons" it has to be resized to its original size.
        [self increaseTableViewHeight];
    }
    
    self.isMemorizationLevelChosen = [NSNumber numberWithBool:NO];
}

- (void)displayFeedBackViewAndNextQuestion{
    // [self.memorizationLevelFeedbackLabel setText:[self selectedStateStringFromLevel:self.memorizationLevel]];
    [self.memorizationLevelFeedbackImageView setImage:[self selectedStateFeedbackImageFromLevel:self.memorizationLevel]];
    [self displayMemorizationLevelSummaryContainerView];
    
    [self performSelector:@selector(displayNextQuestion) withObject:nil afterDelay:0.9];
}


#pragma mark - TableView Animation

static const float animationDuration = .4f;
static const float boundsHeight = 105.f;

- (void)reduceTableViewHeight{
    @try {
        self.tableView.contentMode = UIViewContentModeRedraw;
        [UIView animateWithDuration:animationDuration animations:^{
            CGRect theBounds = self.tableView.bounds;
            CGPoint theCenter = self.tableView.center;
            theBounds.size.height -= boundsHeight;
            theCenter.y -= boundsHeight/2;
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
        [UIView animateWithDuration:animationDuration animations:^{
            CGRect theBounds = self.tableView.bounds;
            CGPoint theCenter = self.tableView.center;
            theBounds.size.height += boundsHeight;
            theCenter.y += boundsHeight/2;
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

#pragma mark - MemorizationLevelSummary Animation

- (void)displayMemorizationLevelSummaryContainerView{
    @try {
        self.tableView.contentMode = UIViewContentModeRedraw;
        [UIView animateWithDuration:animationDuration animations:^{
            self.memorizationLevelSummaryContainerView.alpha = 0.9f;
        }];
        
    }
    @catch (NSException *exception) {
        OLLogDebug(@"%@", exception.reason);
    }
    @finally {
        self.shouldDisplayNextQuestion = [NSNumber numberWithBool:YES];
    }
}

- (IBAction)hideMemorizationLevelSummaryContainerView{
    @try {
        self.tableView.contentMode = UIViewContentModeRedraw;
        [UIView animateWithDuration:animationDuration animations:^{
            self.memorizationLevelSummaryContainerView.alpha = 0.0f;
        }];
        
    }
    @catch (NSException *exception) {
        OLLogDebug(@"%@", exception.reason);
    }
    @finally {
       self.shouldDisplayNextQuestion = [NSNumber numberWithBool:NO];
    }
}


#pragma mark - Footer
/*
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *footerTitle = @"";
    switch (section) {
        case kAnswerSection:
            if ([self.shouldDisplayDescription boolValue] == NO) {
                if ([self.shouldDisplayAnswer boolValue] == NO) {
                    footerTitle = @"Visualisez la réponse et appuyez sur \"Réponse\".";
                }else{
                    if ([self.isMemorizationLevelChosen boolValue]) {
                        footerTitle = [NSString stringWithFormat:@"%d/5 pour cette question. \nPassez à la suivante en cliquant sur la plume en haut à droite.", self.memorizationLevel];
                    }else{
                        footerTitle = @"Appuyez sur la flèche si vous voulez en savoir plus ou choisissez une valeur ci-dessous.";
                    }
                }
            }
            break;
            
        case kDescriptionSection:
            if ([self.isMemorizationLevelChosen boolValue]) {
                footerTitle = [NSString stringWithFormat:@"%d/5 pour cette question. \nPassez à la suivante en cliquant sur la plume en haut à droite.", self.memorizationLevel];
            }else if ([self.shouldDisplayDescription boolValue]) {
                footerTitle = @"Choisissez ci-dessous la valeur qui vous semble le plus à même de représenter votre niveau de mémorisation de cette question.";
            }      break;
            
        default:
            break;
    }
    
    return footerTitle;
}*/


#pragma mark - Memorization Level

- (void)setSelectedState:(BOOL)isSelected toButton:(MemorizationLevel)memorizationLevel{
    switch (memorizationLevel) {
        case MemorizationLevel1:
            [self.level1Button setSelected:isSelected];
            break;
            
        case MemorizationLevel2:
            [self.level2Button setSelected:isSelected];
            break;
            
        case MemorizationLevel3:
            [self.level3Button setSelected:isSelected];
            break;
            
        case MemorizationLevel4:
            [self.level4Button setSelected:isSelected];
            break;
            
        case MemorizationLevel5:
            [self.level5Button setSelected:isSelected];
            break;
            
        default:
            break;
    }
}

- (NSString *)selectedStateStringFromLevel:(MemorizationLevel)memorizationLevel{
    NSString *selectedStateString = @"";
    
    switch (memorizationLevel) {
        case MemorizationLevel1:
            selectedStateString = @"Pas du tout";
            break;
            
        case MemorizationLevel2:
            selectedStateString = @"Un peu";
            break;
            
        case MemorizationLevel3:
            selectedStateString = @"À peu près";
            break;
            
        case MemorizationLevel4:
            selectedStateString = @"Bien";
            break;
            
        case MemorizationLevel5:
            selectedStateString = @"Parfait";
            break;
            
        default:
            break;
    }
    
    return selectedStateString;
}

- (UIImage *)selectedStateFeedbackImageFromLevel:(MemorizationLevel)memorizationLevel{
    UIImage *selectedStateUIImage = [UIImage imageNamed:@""];
    
    switch (memorizationLevel) {
        case MemorizationLevel1:
            selectedStateUIImage = [UIImage imageNamed:@"cancelButtonLevel1.png"];
            break;
            
        case MemorizationLevel2:
            selectedStateUIImage = [UIImage imageNamed:@"cancelButtonLevel2.png"];
            break;
            
        case MemorizationLevel3:
            selectedStateUIImage = [UIImage imageNamed:@"cancelButtonLevel3.png"];
            break;
            
        case MemorizationLevel4:
            selectedStateUIImage = [UIImage imageNamed:@"cancelButtonLevel4.png"];
            break;
            
        case MemorizationLevel5:
            selectedStateUIImage = [UIImage imageNamed:@"cancelButtonLevel5.png"];
            break;
            
        default:
            break;
    }
    
    return selectedStateUIImage;
}

- (void)removePreviousSelectedStateToButton{
    MemorizationLevel memorizationLevel = self.memorizationLevel;
    [self setSelectedState:NO toButton:memorizationLevel];
}

- (void)addSelectedStateToButton{
    MemorizationLevel memorizationLevel = self.memorizationLevel;
    [self setSelectedState:YES toButton:memorizationLevel];
}

- (MemorizationLevel)memorisationLevelFromButton:(UIButton *)button{
    MemorizationLevel memorizationLevel = MemorizationLevel1;
    if (button == self.level1Button) {
        memorizationLevel = MemorizationLevel1;
        
    }else if (button == self.level2Button) {
        memorizationLevel = MemorizationLevel2;
        
    }else if (button == self.level3Button) {
        memorizationLevel = MemorizationLevel3;
        
    }else if (button == self.level4Button) {
        memorizationLevel = MemorizationLevel4;
        
    }else if (button == self.level5Button) {
        memorizationLevel = MemorizationLevel5;
    }
    
    return memorizationLevel;
}

- (IBAction)setMemorizationLevelFromButton:(UIButton *)sender {
    [self removePreviousSelectedStateToButton];
    self.memorizationLevel = [self memorisationLevelFromButton:sender];
    [self addSelectedStateToButton];
    
  // [self addDaysAccordingTo:self.memorizationLevel];
    
    self.isMemorizationLevelChosen = [NSNumber numberWithBool:YES];
    
    // Display the next question as the user selects his memorization level.
    [self displayFeedBackViewAndNextQuestion];
}

@end
