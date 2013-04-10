//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionSetTableViewCell.h
// Created     : $ 10/04/13 $
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

#import "AutoResizeLabelTableViewCell.h"

@interface QuestionSetTableViewCell : AutoResizeLabelTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nextDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextQuestionsNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *gaugeContainerView;


#pragma mark - Accessors

//! Set the percent for the gauge of the UIGaugeController.
//! @param[in] progress : The percent of the progress bar.
- (void)setGaugeProgress:(float)progress;

@end
