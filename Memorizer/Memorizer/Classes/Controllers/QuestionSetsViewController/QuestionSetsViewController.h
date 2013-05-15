//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionSetsViewController.h
// Created     : $ 12/04/13 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2013, All Rights Reserved
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
// 

#import "HelpViewController.h"

@interface QuestionSetsViewController : HelpViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//! Calculate the gauge progress percent according to the question saved memorization level.
//! @param [in] indexPath : The indexPath for the cell we want to calculate the "question done percent".
- (float)questionDonePercentAtIndexPath:(NSIndexPath *)indexPath;

@end
