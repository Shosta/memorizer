//
//  Tokens.m
//  MobinilAndMe
//
//  Created by Rémi LAVEDRINE on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// 

#import "Tokens.h"
#import "SDKAuthenticationPlatform.h"

@implementation Tokens

NSString *kArchiveFileName = @"AppData.archive";

NSString *kRefreshDataDoneKey = @"RefreshDataDoneKey";

NSString *kRefreshDataStartKey= @"RefreshDataStartKey";

//! URL
#ifdef USE_PROD_OFR_PLATFORM
NSString *kBaseURLKey = @"http://sso.orange.com/";
#endif

#ifdef USE_PREPROD_COM_PLATFORM
NSString *kBaseURLKey = @"http://tb1n.orange.com/";
#endif

//! Application
BOOL hasFAQ = NO;

//! Language choice
NSString *kLanguageChoiceKey = @"LanguageChoice";
NSString *kBelgiumFrenchLanguage = @"fr-BE";
NSString *kBelgiumDutchLanguage = @"nl-BE";

//! Date Format
NSString *kDayMonthHourMinutesFormatDate = @"d MMMM, HH:mm";
NSString *kDayMonthFormatDate = @"d MMMM";


NSString * kBalanceUsage = @"BalanceUsage";
//! BalanceItems type constants.
NSString *kBalanceItemCreditTypeKey = @"credit";
NSString *kBalanceItemDataTypeKey = @"data";
NSString *kBalanceItemMinutesTypeKey = @"voice";
NSString *kBalanceItemSMSTypeKey = @"sms";


//! Store List NSDictionary object key.
NSString *kStoreListKey = @"storeList";
NSString *kStoreSectionsKey = @"sections";
NSString *kStoreSectionNameKey = @"sectionName";
NSString *kStoreStoresKey = @"stores";

//! Stores NSDictionary object key.
NSString *kStoreSectionKey = @"section";
NSString *kStoreNameKey = @"name";
NSString *kStoreAddressKey = @"address";
NSString *kStoreWorkingHoursKey = @"workingHours";
NSString *kStoreLatitudeKey = @"latitude";
NSString *kStoreLongitudeKey = @"longitude";
NSString *kStoreTypeKey = @"type";
NSString *kStorePhoneNumberKey = @"phoneNumber";
NSString *kStoreCharacteristicsKey = @"characteristics";
NSString *kStoreDistanceFromLocationKey = @"storeDistanceFromLocation";

//! Store Locator
int kSectionInterval = 500;
NSString *kIsDisplayingListForStoreLocatorKey = @"IsDisplayingListForStoreLocatorKey";

//! About Header NSDictionary object key.
NSString *kApplicationTitleKey = @"applicationTitle";
NSString *kApplicationVersionNumberKey = @"applicationVersionNumber";
NSString *kApplicationRevisionNumberKey = @"applicationRevisionNumber";
NSString *kApplicationCopyrightMentionKey = @"applicationCopyrightMention";

//! About Section NSdictionary object key.
NSString *kApplicationAboutSectionNameKey = @"sectionName";
NSString *kApplicationAboutSectionBodyKey = @"sectionBody";

@end
