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

#import "AlignScrollViewController.h"
#import "HelpViewController.h"
#import "UINavigationController+Animations.h"

@interface QuestionSetsViewController : HelpViewController

//! Calculate the gauge progress percent according to the question saved memorization level.
//! @param [in] indexPath : The indexPath for the cell we want to calculate the "question done percent".
- (float)questionDonePercentAtIndexPath:(NSIndexPath *)indexPath;

//! <#Method comment#>
//! @param[in] <#param#> : <#param description#>
- (CGFloat)detailElementTextHeight:(NSString *)detailElementText;

@end
