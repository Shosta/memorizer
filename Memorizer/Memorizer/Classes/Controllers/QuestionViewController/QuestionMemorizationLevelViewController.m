//
//  QuestionMemorizationLevelViewController.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 11/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionMemorizationLevelViewController.h"

@implementation QuestionMemorizationLevelViewController

static const int kStatementSection = 0;
static const int kAnswerSection = 1;
static const int kDescriptionSection = 2;


#pragma mark - Object

- (id)initWithQuestionSet:(NSMutableArray *)aQuestionSetArray{
  return [super initWithNibName:@"QuestionMemorizationLevelViewController" bundle:nil questionSet:aQuestionSetArray];
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
	return [NSArray arrayWithObjects:kIsMemorizationLevelChosenKey, nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (![NSThread isMainThread]) {
		[self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
	} else {
		[self updateUIForKeypath:keyPath];
	}
}

- (void)updateUIForKeypath:(NSString *)keyPath {
	if ([keyPath isEqualToString:kIsMemorizationLevelChosenKey]) {
    if (self.shouldDisplayDescription){
      [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kDescriptionSection] withRowAnimation:UITableViewRowAnimationFade];
    }else if (self.shouldDisplayAnswer) {
      [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
    } 
	}
}


#pragma mark - View

- (void)viewDidLoad{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self registerForKVO];
}

- (void)viewDidUnload{
  [super viewDidUnload];
  
  [self unregisterFromKVO];
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
  [super displayNextQuestion];
  
  if (self.currentQuestionIndex< [self.questionSetArray count]){
    // 1. As the TableView's height was reduced to present the "noting buttons" it has to be resized to its original size.
    [self increaseTableViewHeight];
  }
  
  self.isMemorizationLevelChosen = [NSNumber numberWithBool:NO];
}


#pragma mark - Animation

static const float animationDuration = .4f;
static const float boundsHeight = 64.f;

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


#pragma mark - Selection

/**
 @brief Display the Answer when the user taps the cell.
 @author : Rémi Lavedrine
 @date : 11/04/2013
 @remarks : It reloads only the "kAnswerSection" section to avoid unnecessary redraw.
 It reduces the TableView height to make the "Memorizatoin level buttons" available.
 */
- (void)displayAnswer{
  if (!self.shouldDisplayAnswer) {
    [self reduceTableViewHeight];
    
    self.shouldDisplayAnswer = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kAnswerSection] withRowAnimation:UITableViewRowAnimationFade];
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
          if ([self.isMemorizationLevelChosen boolValue]) {
            footerTitle = @"%d/5 pour cette question. \nPassez à la suivante en cliquant sur la plume en haut à droite.";
          }else{
            footerTitle = @"Appuyez sur la flèche si vous voulez en savoir plus.";
          }
        }
      }
      break;
      
    case kDescriptionSection:
      if ([self.isMemorizationLevelChosen boolValue]) {
        footerTitle = @"%d/5 pour cette question. \nPassez à la suivante en cliquant sur la plume en haut à droite.";
      }else if (self.shouldDisplayDescription) {
        footerTitle = @"Choisissez ci-dessous la valeur qui vous semble le plus à même de représenter votre niveau de mémorisation de cette question.";
      }      break;
      
    default:
      break;
  }
  
  return footerTitle;
}


#pragma mark - Memorization Level

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
  self.memorizationLevel = [self memorisationLevelFromButton:sender];
  
  switch (self.memorizationLevel) {
    case MemorizationLevel1:
      OLLogDebug(@"Change the next presentation date according to the level 1 memorization.");
      break;
      
    case MemorizationLevel2:
      OLLogDebug(@"Change the next presentation date according to the level 2 memorization.");
      
      break;
      
    case MemorizationLevel3:
      OLLogDebug(@"Change the next presentation date according to the level 3 memorization.");
      
      break;
      
    case MemorizationLevel4:
      OLLogDebug(@"Change the next presentation date according to the level 4 memorization.");
      
      break;
      
    case MemorizationLevel5:
      OLLogDebug(@"Change the next presentation date according to the level 5 memorization.");
      
      break;
      
    default:
      break;
  }
  
  self.isMemorizationLevelChosen = [NSNumber numberWithBool:YES];
}

@end
