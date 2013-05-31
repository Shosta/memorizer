//
//  Tokens.m
//  MobinilAndMe
//
//  Created by Rémi LAVEDRINE on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// 

#import "Tokens.h"

@implementation Tokens

NSString *kArchiveFileName = @"AppData.archive";

//! First Launch Help
//NSString *kIsQuestionSetMemorizationHelpAlreadyDisplayedKey = @"isQuestionSetMemorizationHelpAlreadyDisplayed";
//NSString *kIsQuestionStatementHelpAlreadyDisplayedKey = @"isQuestionStatementHelpAlreadyDisplayed";
//NSString *kIsQuestionAnswerHelpAlreadyDisplayedKey = @"isQuestionAnswerHelpAlreadyDisplayed";

NSString *kQuestionSetHelpViewLastDisplayedDateKey = @"QuestionSetHelpViewLastDisplayedDate";
NSString *kQuestionStatementHelpViewLastDisplayedDateKey = @"QuestionStatementHelpViewLastDisplayedDate";
NSString *kQuestionAnswerHelpViewLastDisplayedDateKey = @"QuestionAnswerHelpViewLastDisplayedDate";


//! Date Format
NSString *kDayMonthHourMinutesFormatDate = @"d MMMM, HH:mm";
NSString *kDayMonthYearFormatDate = @"d MMMM yyyy";
NSString *kDayMonthFormatDate = @"d MMMM";

//! Cell QuestionSet
int kCellQuestionSetPaddingX = 10;
int kCellQuestionSetPaddingY = 10;
int kCellQuestionSetTitleOriginMajorY = 57;
int kCellQuestionSetTitleOriginMinorY = 57;
int kCellQuestionSetDefaultTextWidth = 280;
int kCellQuestionSetInfoContainerViewHeight = 241;
int kCellQuestionSetListInfoContainerViewHeight = 37;
int kCellQuestionSetStatisticsInfoContainerViewHeight = 203;

//! Cell Answer
int kCellStatementPaddingX = 10;
int kCellStatementPaddingY = 10;
int kCellStatementDefaultTextWidth = 280;

//! Cell Answer
int kCellAnswerPaddingX = 10;
int kCellAnswerPaddingY = 10;
int kCellAnswerDefaultTextWidth = 235;

//! Cell Description
int kCellDescriptionPaddingX = 10;
int kCellDescriptionPaddingY = 10;
int kCellDescriptionDefaultTextWidth = 280;


@end
