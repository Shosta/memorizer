//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : AnswerTableViewCell.h
// Created     : $ 08/04/13 $
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

@interface AnswerTableViewCell : AutoResizeLabelTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *descriptionImageView;
@property (weak, nonatomic) IBOutlet UIButton *playSoundButton;
@property (nonatomic, retain) NSString *soundFileName;


#pragma mark - Animations

//! Start a fade in animation on the "descriptionImageView" in order to let it appear.
- (void)fadeInDescriptionImageView;

//! Start a fade in animation on the "playSoundButton" in order to let it appear.
- (void)fadeInPlaySoundButton;

@end
