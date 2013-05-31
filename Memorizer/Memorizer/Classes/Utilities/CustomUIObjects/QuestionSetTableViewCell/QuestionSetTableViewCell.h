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



//! Cell's style.
typedef enum{
  QuestionSetTableViewCellMajorStyle, // detailElementTextLabel is used and has to be shown
  QuestionSetTableViewCellMinorStyle  // detailElementTextLabel isn't used and has to be hidden
}QuestionSetTableViewCellStyle;

@interface QuestionSetTableViewCell : AutoResizeLabelTableViewCell

@property (weak, nonatomic) IBOutlet UIView *questionSetInfoContainerView;
@property (weak, nonatomic) IBOutlet UILabel *nextDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextDateQuestionsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingQuestionsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *allQuestionsNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *questionSetProgressionAnimatedImageView;
@property (weak, nonatomic) IBOutlet UILabel *seeNextActionLabel;


#pragma mark - Accessors

- (void)setAnimatedImageAnimationFromPercent:(float)percent;


#pragma mark - Setters

//! Change the position of the image.
- (void)setCellStyle:(QuestionSetTableViewCellStyle)style;


@end
