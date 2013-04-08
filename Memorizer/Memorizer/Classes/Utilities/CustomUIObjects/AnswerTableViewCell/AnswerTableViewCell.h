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

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UIButton *showDescriptionLabel;

@end
