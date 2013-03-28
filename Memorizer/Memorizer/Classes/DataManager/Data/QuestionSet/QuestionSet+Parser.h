//
//  QuestionSet+Parser.h
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSet.h"

@interface QuestionSet (Parser)

//! Create a Question object from an NSdictionary object returned from the parsing.
//! @param [in] questionSetDict : The NSDictionary object that represents the question Set and that need to be parsed.
//! @param [out] QuestionSet : The QuestionSet object created from the parsing.
+ (QuestionSet *)parse:(NSDictionary *)questionSetDict;

@end
