//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionSet.h
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

#import <Foundation/Foundation.h>

//! @brief A set of question that represents some stuff to memorize.
//! @class QuestionSet
//! @ingroup Data
//! @author Rémi Lavedrine
@interface QuestionSet : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *shortTitle;
@property (nonatomic, retain) NSMutableArray *questionsArray;

@end
