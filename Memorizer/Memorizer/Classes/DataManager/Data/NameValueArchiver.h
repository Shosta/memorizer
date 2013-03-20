//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : MobinilAndMe
// File        : NameValueArchiver.h
// Created     : $ 27/04/12 $
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
// Describe an Object from the init request JSON file response.
// A NameValueArchiver object contains a name (NSString) and a value (NSString).
// It implements the NSCoding protocol to handle archiving process.
// 

#import <Foundation/Foundation.h>


//! @brief Describe an Object from the init request JSON file response.
//! @class NameValueArchiver
//! @ingroup DataManager
//! @author Rémi Lavedrine
@interface NameValueArchiver : NSObject <NSCoding>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;

- (NSString *)description;

@end
