//
//  Question.h
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>

//! @brief Describes a Question object.
//! @class Question
//! @ingroup Data
//! @author Rémi Lavedrine
@interface Question : NSObject
@property (nonatomic, retain) NSString *statement;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSDate *nextPresentationDate;

@end
