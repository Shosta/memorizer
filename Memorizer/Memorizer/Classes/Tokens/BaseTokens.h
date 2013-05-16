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


//! Generic cell
#define CUSTOM_TABLEVIEW_X_PADDING 7
#define CUSTOM_TABLEVIEW_Y_PADDING 12
#define GENERIC_BALANCE_CELL_IMAGE_WIDTH 26
#define GENERIC_BALANCE_CELL_IMAGE_HEIGH 26
#define UPPER_AND_LOWER_PART_PADDING 0
#define CELL_BACKGROUND_COLOR [UIColor whiteColor]

//! About
#define ABOUT_HEADER_COPYRIGHT_TEXT_ORIGIN 171

#define CELL_MINOR_STYLE_LABEL_COLOR [UIColor lightGrayColor]
#define CELL_MAJOR_STYLE_LABEL_COLOR [UIColor blackColor]

//! FONTS
//! QuestionSet Cell Fonts
#define QUESTIONSET_CELL_TEXT_FONT [UIFont boldSystemFontOfSize:17]

//! Statement Cell Fonts
#define STATEMENT_CELL_TEXT_FONT_MAJOR_STYLE [UIFont boldSystemFontOfSize:17]
#define STATEMENT_CELL_TEXT_FONT_MINOR_STYLE [UIFont systemFontOfSize:17]

//! Answer Cell Fonts
#define ANSWER_CELL_TEXT_FONT_MAJOR_STYLE [UIFont boldSystemFontOfSize:17]
#define ANSWER_CELL_TEXT_FONT_MINOR_STYLE [UIFont systemFontOfSize:17]

//! Description Cell Text Fonts
#define DESCRIPTION_CELL_TEXT_FONT [UIFont systemFontOfSize:17]


//! About Cell's style.
typedef enum{
  AboutTableViewCellBlackStyle, // Labels are displayed in White and the Background of the RootView is Black.
  AboutTableViewCellWhiteStyle  // Labels are displayed in Black and the Background of the RootView is White.
}AboutTableViewCellStyle;

//! The Memorization Level for a Question.
typedef enum{
  NoMemorizationLevel,
  MemorizationLevel1, // From the Worst.
  MemorizationLevel2,
  MemorizationLevel3,
  MemorizationLevel4,
  MemorizationLevel5  // To the Best.
}MemorizationLevel;

//! The Presentation Time for a question according to the Current Date and the question's next presentation date.
typedef enum{
  Earlier, // The question was presented earlier than the date it should.
  OnTime, // The question was presented the correct it should.
  Later// The question was presented later than the date it should.
}PresentationTime;
