//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : AutoResizeLabelTableViewCell.h
// Created     : $ 09/04/13 $
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

@interface AutoResizeLabelTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *textLabel;

#pragma mark - Redraw

//! Dynamically redesign the cell's left label (TextLabel) UI if needed.
//! @param [in] UIFont : The font used for the label.
//! @param [in] UIColor : The label's text color.
//! @param [in] NSTextAlignment : The label's text alignment.
//! @param [in] int : The label's text width.
//! @param [in] int : The label's text x origin position on the left upper position.
//! @param [in] int : The label's text y origin position on the left upper position. 
- (void)configureTextLabelUIWithLabelFont:(UIFont *)font
                               labelColor:(UIColor *)color
                       labelTextAlignment:(NSTextAlignment)textAlignment
                               labelWidth:(int)width
                      labelStartXPosition:(int)startXPosition
                      labelStartYPosition:(int)startYPosition;
@end
