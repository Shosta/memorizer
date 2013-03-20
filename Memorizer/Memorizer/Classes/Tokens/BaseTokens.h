//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : MobinilAndMe
// File        : BaseTokens.h
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
// A class that contains all the tokens which only need to be described on a single header file (just as a #define command for instance).
// This class is imported in Tokens.h which is imported in all project's classes through the "MobinilAndMe-Prefix.pch" file.
// 

#import <Foundation/Foundation.h>

//! Screen components size (iOS 6 requirements)
#define MAIN_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define STATUS_BAR_WIDTH      [UIApplication sharedApplication].statusBarFrame.size.width
#define STATUS_BAR_HEIGHT     [UIApplication sharedApplication].statusBarFrame.size.height
#define NAVIGATION_BAR_WIDTH  self.navigationController.navigationBar.bounds.size.width
#define NAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.bounds.size.height
#define TAB_BAR_WIDTH         self.tabBarController.tabBar.bounds.size.width
#define TAB_BAR_HEIGHT        self.tabBarController.tabBar.bounds.size.height

//! App delegate and App data shared instance
#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define MANAGER_LAUNCH_APP [ManagerLaunchApp sharedInstance]
#define APP_DATA [AppData sharedInstance]

//! Session management
#define SESSION_GET(key) [[APP_DELEGATE allSessionValues] getObjectWithKey:key]
#define SESSION_SET(key,value) [[APP_DELEGATE allSessionValues] addObject:value forKey:key]
#define SESSION_REMOVE(key)  [[APP_DELEGATE allSessionValues] removeObject:key]

//! Refresh management
#define REFRESH_DATA_DONE_NOTIFICATION [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshDataDoneKey object:nil];
#define REFRESH_DATA_START_NOTIFICATION [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshDataStartKey object:nil];
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEADER_TEXT_COLOR [UIColor colorWithRed:27.0/100 green:27.0/100 blue:27.0/100 alpha:1]

#define ORANGE_DIGITAL_1 UIColorFromRGB(0xFF7900)
#define ORANGE_DIGITAL_2 UIColorFromRGB(0xF16E00)

//! Generic cell
#define CUSTOM_TABLEVIEW_X_PADDING 7
#define CUSTOM_TABLEVIEW_Y_PADDING 12
#define GENERIC_BALANCE_CELL_IMAGE_WIDTH 26
#define GENERIC_BALANCE_CELL_IMAGE_HEIGH 26
#define UPPER_AND_LOWER_PART_PADDING 0
#define CELL_BACKGROUND_COLOR [UIColor whiteColor]

//! About
#define ABOUT_HEADER_COPYRIGHT_TEXT_ORIGIN 171

//! UIHeader
#define UIHEADER_START_X_POSITION 20
#define UIHEADER_START_Y_POSITION 17
#define UIHEADER_PADDING_Y 10

//! UIFooter
#define UIFOOTER_START_X_POSITION 20
#define UIFOOTER_START_Y_POSITION 5
#define UIFOOTER_PADDING_Y 5

//! Cell on Store Locator.
#define MINOR_LABEL_WIDTH 65
#define MAJOR_LABEL_WIDTH 200
#define CELL_X_PADDING 10
#define CELL_Y_PADDING 15

#define CELL_MINOR_STYLE_LABEL_COLOR [UIColor lightGrayColor]
#define CELL_MAJOR_STYLE_LABEL_COLOR [UIColor blackColor]

//! Cell on Balance
#define BALANCE_DETAILED_CELL_DEFAULT_TEXT_WIDTH 280 // The width of each label that contains text (which means "textLabel", "detailTextLabel", "detailElementTextLabel" and "descriptionTextLabel").



//! FONTS
//! Side Menu Fonts
#define SIDE_MENU_HEADER_FONT [UIFont systemFontOfSize:15]
#define SIDE_MENU_CELL_TEXT_FONT [UIFont boldSystemFontOfSize:17]

//! Generic cell Fonts
#define GENERIC_BALANCE_HEADER_LABEL_BOLD_LABEL_FONT [UIFont boldSystemFontOfSize:17]
#define GENERIC_BALANCE_HEADER_LABEL_LABEL_FONT [UIFont systemFontOfSize:15]
#define GENERIC_BALANCE_CELL_MAJOR_STYLE_LABEL_FONT [UIFont boldSystemFontOfSize:17]
#define GENERIC_BALANCE_CELL_MINOR_STYLE_LABEL_FONT [UIFont systemFontOfSize:17]
#define GENERIC_BALANCE_CELL_DESCRIPTION_LABEL_FONT [UIFont systemFontOfSize:14]

//! UIHeader Fonts
#define HEADER_TEXT_LABEL_FONT [UIFont boldSystemFontOfSize:17]
#define HEADER_DETAIL_TEXT_LABEL_FONT [UIFont systemFontOfSize:15]

//! Cell on Store Locator Fonts
#define CELL_MINOR_STYLE_LABEL_FONT [UIFont boldSystemFontOfSize:16]
#define CELL_MAJOR_STYLE_LABEL_FONT [UIFont boldSystemFontOfSize:16]

//! Invoices Fonts
#define INVOICES_HEADER_TEXT_LABEL_FONT [UIFont boldSystemFontOfSize:17]
#define INVOICES_FOOTER_TEXT_LABEL_FONT [UIFont systemFontOfSize:15]
#define INVOICES_SMALL_FONT [UIFont systemFontOfSize:13]
#define INVOICES_SMALL_BOLD_FONT [UIFont boldSystemFontOfSize:13]
#define INVOICES_DATE_BOLD_TEXT_LABEL_FONT [UIFont boldSystemFontOfSize:16]
#define INVOICES_DATE_TEXT_LABEL_FONT [UIFont systemFontOfSize:16]
#define INVOICES_AMOUNT_BOLD_TEXT_LABEL_FONT [UIFont boldSystemFontOfSize:17]
#define INVOICES_AMOUNT_TEXT_LABEL_FONT [UIFont systemFontOfSize:17]

//! Cell on Balance Fonts
#define BALANCE_DETAILED_CELL_TEXT_LABEL_FONT [UIFont boldSystemFontOfSize:15]
#define BALANCE_DETAILED_CELL_DESCRIPTION_TEXT_LABEL_FONT [UIFont systemFontOfSize:15]


//! Location management
#define LOCATION_AWARE_ID @"locationAwareId"
#define ADDRESS_LOCATION_AWARE_ID @"addressLocationAwareId"
#define LOCATION_AVAILABILITY_ID @"locationAvailabilityId"

//! Balance Image Names
#define WARNING_IMAGE @"warning_icon.png"
#define WARNING_IMAGE_HIGHLIGHTED @"warning_icon_on.png"
#define DOLPHIN_PLAN_IMAGE @"plan_dolphin.png"
#define KANGAROO_PLAN_IMAGE @"plan_kangoroo.png"
#define PANTHER_PLAN_IMAGE @"plan_panther.png"
#define SQUIRREL_PLAN_IMAGE @"plan_squirrel.png"


//! Balance Style Names
#define STANDARD_DISPLAY_TYPE @"ok"
#define WARNING_DISPLAY_TYPE @"outofbundle"

//! operation identifier
enum operationIdentifier {
  //! INIT operation
  INIT_ID = 0,
  //! GET operation
  GET_ID
};

//! operation identifier
typedef enum{
  operationIdentifierGetId,
  operationIdentifierInitId
}operationIdentifier;

//! Operation state.
enum operationState {
	//! Idle status.
  IDLE = 0,
	//! In progress status.
  IN_PROGRESS,
	//! Success status.
  SUCCESS,
	//! Failed status.
	FAILED
};

//! Operation state.
typedef enum{
  operationStateIdle,
  operationStateInProgress,
  operationStateSuccess,
  operationStateFailed
}operationState;

//! About Cell's style.
typedef enum{
  AboutTableViewCellBlackStyle, // Labels are displayed in White and the Background of the RootView is Black.
  AboutTableViewCellWhiteStyle  // Labels are displayed in Black and the Background of the RootView is White.
}AboutTableViewCellStyle;

//! Balance Cell's display style.
typedef enum{
  BalancePartTableViewCellWarningStyle, // textLabel is in Red.
  BalancePartTableViewCellStandardStyle  // textLabel used the standardColor.
}BalancePartTableViewCellDisplayStyle;

//! BalanceCell images.
typedef enum{
    pantherPlanImage,
    dolphinPlanImage,
    kangorooPlanImage,
    squirrelPlanImage,
    warningImage,
    noImage
}BalanceCellImageType;

//! Invoices date format :
#define INVOICES_DATE_FORMAT @"yyyy'-'MM'-'dd'T'hh':'mm':'ss'+'hh':'mm"
/** Float: Portrait Screen Height **/
#define SCREEN_HEIGHT_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.height )

/** Float: Portrait Screen Width **/
#define SCREEN_WIDTH_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Height **/
#define SCREEN_HEIGHT_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.width )
/** Float: Landscape Screen Width **/
#define SCREEN_WIDTH_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.height )
//! Invoices date format :
#define OPTIONS_DATE_FORMAT @"d MMMM, HH:mm"