//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : Memorizer
// File        : AppData.h
// Created     : $ 25/04/12 $
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
// Singleton class that describing the objects tree which describes all the Objects needed to fill the UI.
// It has a reference to an InitManager object and a GetManager object.
// This object is updated on "return from background" and on "app launching".
// This object is serialized on "enter background" and "app finished".
//

#import <Foundation/Foundation.h>

//! @brief Singleton class that describing the objects tree which describes all the Objects needed to fill the UI.
//! @class AppData
//! @ingroup DataManager
//! @author Rémi Lavedrine
@interface AppData : NSObject

@property (nonatomic, retain) NSMutableArray *questionSetsArray;

//! Create or return the shared instance. Register to quit app notifications.
+ (AppData *)sharedInstance;

@end
