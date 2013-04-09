//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : MobinilAndMe
// File        : NSString+LabelSize.h
// Created     : $ 11/06/12 $
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
// Calculate a Label size based on its content and a width.
// It is really useful when you wants to calculate a cell's height from its NSString label's content.
//

#import <Foundation/Foundation.h>


//! @brief Calculate a Label size based on its content and a width.
//! @class NSString+LabelSize
//! @ingroup Utilities
//! @author Rémi Lavedrine
@interface NSString (LabelSize)

- (CGFloat)getTextHeightAtFont:(UIFont*)font forWidth:(CGFloat)width;

@end
