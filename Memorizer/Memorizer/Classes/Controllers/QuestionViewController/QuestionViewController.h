//
//  QuestionViewController.h
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;


#pragma mark - Object
//! <#Method comment#>
//! @param[in]      nibNameOrNil : <#param description#>
//! @param[in]    nibBundleOrNil : <#param description#>
//! @param[in] aQuestionSetArray : <#param description#>
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
          questionSet:(NSMutableArray *)aQuestionSetArray;

//! <#Method comment#>
//! @param[in] aQuestionSetArray : <#param description#>
- (id)initWithQuestionSet:(NSMutableArray *)aQuestionSetArray;

@end
