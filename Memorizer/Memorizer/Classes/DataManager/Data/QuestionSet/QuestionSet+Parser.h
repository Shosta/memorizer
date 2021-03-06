//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionSet+Parser.h
// Created     : $ 21/03/13 $
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

#import "QuestionSet.h"

@interface QuestionSet (Parser)

//! Create a Question object from an NSdictionary object returned from the parsing.
//! @param [in] questionSetDict : The NSDictionary object that represents the question Set and that need to be parsed.
//! @param [out] QuestionSet : The QuestionSet object created from the parsing.
+ (QuestionSet *)parse:(NSDictionary *)questionSetDict;

@end
