//
//  QuestionSet.h
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>

//! @brief A set of question that represents some stuff to memorize.
//! @class QuestionSet
//! @ingroup Data
//! @author Rémi Lavedrine
@interface QuestionSet : NSObject
@property (nonatomic, retain) NSMutableArray *questionsArray;

@end
