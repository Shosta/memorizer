//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionSetsViewController.h
// Created     : $ 28/03/13 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright France Telecom 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of France Telecom.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// France Telecom.
//--------------------------------------------------------
//
// @brief
// Displays a list of QuestionSet.
// Each QuestionSet could be choosed.
//

#import <UIKit/UIKit.h>
#import "OLStatusView.h"

@interface QuestionSetsViewController : UIViewController <OLStatusViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - Refresh View

//! <#Describe the function purpose#>
- (void)refreshView;

@end
