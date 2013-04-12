//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : NextPresentationQuestionSet.h
// Created     : $ 12/04/13 $
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
// Describes a Subset of the entire QuestionSet.
// It is composed only with the Question from the QuestionSet whose "nextPresentationDate" are equal or previous to the current date (today).
// It has as well a NSDate object that represents the next presentation date.
// 

#import <Foundation/Foundation.h>

@class QuestionSet;

@interface NextPresentationQuestionSet : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableArray *nextPresentationQuestionArray;
@property (nonatomic, retain) NSDate *nextPresentationDate;


#pragma mark - Object

//! <#Describe the function purpose#>
- (id)initWithQuestionSet:(QuestionSet *)aQuestionSet;

@end