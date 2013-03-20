//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : MobinilAndMe
// File        : Tokens.h
// Created     : $ 20/04/2012 $
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
// A class that contains all the tokens needed for the app in order to described it in one single location in the project.
// This class is imported in all project's classes through the "MobinilAndMe-Prefix.pch" file.
//

#import <Foundation/Foundation.h>
#import "BaseColorTokens.h"
#import "BaseTokens.h"

@interface Tokens : NSObject

extern NSString *kArchiveFileName;

extern NSString *kRefreshDataDoneKey;

extern NSString *kRefreshDataStartKey;

//! URL
extern NSString *kBaseURLKey;

//! Application
extern BOOL hasFAQ;

//! Language choice
extern NSString *kLanguageChoiceKey;
extern NSString *kBelgiumFrenchLanguage;
extern NSString *kBelgiumDutchLanguage;

//! Date Format
extern NSString *kDayMonthHourMinutesFormatDate;
extern NSString *kDayMonthFormatDate;

//! Balance showing mode:
extern NSString *kBalanceUsage;
//! BalanceItems type constants.
extern NSString *kBalanceItemCreditTypeKey;
extern NSString *kBalanceItemDataTypeKey;
extern NSString *kBalanceItemMinutesTypeKey;
extern NSString *kBalanceItemSMSTypeKey;

//! Store List NSDictionary object key.
extern NSString *kStoreListKey;
extern NSString *kStoreSectionsKey;
extern NSString *kStoreSectionNameKey;
extern NSString *kStoreStoresKey;
//! Stores NSDictionary object key.
extern NSString *kStoreSectionKey;
extern NSString *kStoreNameKey;
extern NSString *kStoreAddressKey;
extern NSString *kStoreWorkingHoursKey;
extern NSString *kStoreLatitudeKey;
extern NSString *kStoreLongitudeKey;
extern NSString *kStoreTypeKey;
extern NSString *kStorePhoneNumberKey;
extern NSString *kStoreCharacteristicsKey;
extern NSString *kStoreDistanceFromLocationKey;

//! Store Locator
extern int kSectionInterval;
extern NSString *kIsDisplayingListForStoreLocatorKey;

//! About Header NSDictionary object key.
extern NSString *kApplicationTitleKey;
extern NSString *kApplicationVersionNumberKey;
extern NSString *kApplicationRevisionNumberKey;
extern NSString *kApplicationCopyrightMentionKey;

//! About Section NSdictionary object key.
extern NSString *kApplicationAboutSectionNameKey;
extern NSString *kApplicationAboutSectionBodyKey;

@end
