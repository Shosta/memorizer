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


//! Date Format
extern NSString *kDayMonthHourMinutesFormatDate;
extern NSString *kDayMonthYearFormatDate;
extern NSString *kDayMonthFormatDate;


//! Cell QuestionSet
extern int kCellQuestionSetPaddingX;
extern int kCellQuestionSetPaddingY;
extern int kCellQuestionSetOriginY;
extern int kCellQuestionSetDefaultTextWidth;

//! Cell Statement
extern int kCellStatementPaddingX;
extern int kCellStatementPaddingY;
extern int kCellStatementDefaultTextWidth;

//! Cell Answer
extern int kCellAnswerPaddingX;
extern int kCellAnswerPaddingY;
extern int kCellAnswerDefaultTextWidth;

//! Cell Description
extern int kCellDescriptionPaddingX;
extern int kCellDescriptionPaddingY;
extern int kCellDescriptionDefaultTextWidth;

@end
