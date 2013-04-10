//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : DescriptionTableViewCell.h
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

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Date)

//! <#Method comment#>
//! @param[in] <#param#> : <#description#>
+ (NSString *)dateStringFromString:(NSString *)sourceString
                      sourceFormat:(NSString *)sourceFormat
                 destinationFormat:(NSString *)destinationFormat;

//! <#Method comment#>
//! @param[in] <#param#> : <#description#>
+ (NSDate *)dateFromString:(NSString *)sourceString
              sourceFormat:(NSString *)sourceFormat;

//! <#Method comment#>
//! @param[in] <#param#> : <#description#>
+ (NSString *)dateStringForCurrentDateWithFormat:(NSString *)destinationFormat;

//! Return a NSString from a NSDate object with the provided "Destination Format" and with the "Settings Locale".
//! @param  [in]              date : The NSDate we want to get the NSString.
//! @param  [in] destinationFormat : The NSString that describes the NSDate object destination format.
//! @param [out]          NSString : The NSString that describes the NSDate object with the correct destination format.
+ (NSString *)dateStringFromDate:(NSDate *)date
               destinationFormat:(NSString *)destinationFormat;
@end
