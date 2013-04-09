//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : MobinilAndMe
// File        : UILabel+Size.h
// Created     : $ 04/05/12 $
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
// Calculate a Label Size from its content and its position.
// It is useful when you want to adapt a UILabel size according to its x;y origin, its width and its content.
// It can then adapt a cell's height from a dynamic content.
//

#import <UIKit/UIKit.h>


//! @brief Calculate a Label Size from its content and its position.
//! @class UILabel+Size
//! @ingroup Utilities
//! @author Rémi Lavedrine
@interface UILabel (Size)

//! Adjusts Adjusts UILabel's frame to begin at defined x and y position and have a dynamic height
//! @param[in] startX - value that the frames x coord to be
//! @param[in] startY - value that the frames y coord to be
-(void)setUpMultiLineFrameWithStartXPosition:(CGFloat)startX withStartYPosition:(CGFloat)startY;

//! Adjusts UILabel's frame to begin at defined x position, to maxiumum width and height, centered veritcally based on maxHeight and height of content
//! @param[in] width     : value that the frames width property will be
//! @param[in] startX    : value that the frames x coord to be
//! @param[in] maxHeight : value that the frames height property will be
-(void)setUpMultiLineFrameBasedOnWidth:(CGFloat)width withStartXPosition:(CGFloat)startX withHeight:(CGFloat)maxHeight; 

//! Adjusts UILabel's frame to begin at defined x and y position, to maxiumum width and have a dynamic height
//! @param[in] maxWidth : value that the frames width property will be
//! @param[in] startX   : value that the frames x coord to be
//! @param[in] startY   : value that the frames y coord to be
-(void)setUpMultiLineFrameBasedOnWidth:(CGFloat)maxWidth withStartXPosition:(CGFloat)startX withStartYPosition:(CGFloat)startY;

//! Adjusts UILabel's frame to begin at defined x position, to maximum width
//! @param[in] maxWidth : value that the frames width property will be
//! @param[in] startX   : value that the frames x coord to be
-(void)setUpMultiLineFrameBasedOnWidth:(CGFloat)maxWidth withStartXPosition:(CGFloat)startX;

//! Returns height value of UILabel based on content and max width
//! @param[in] width : max width of content
//! @return height of UILabel
-(CGFloat)getHeightBasedOnWidth:(CGFloat)width;

//! Returns size of UILabel based on content
//! @return Size of UILabel
-(CGSize)getSize;

@end
