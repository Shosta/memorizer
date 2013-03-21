//
//  Question+Parser.h
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Question.h"

@interface Question (Parser)

#pragma mark - Parsing
//! Create a Question object from an NSdictionary object returned from the parsing.
//! @param  [in] questionDict :
//! @param [out]     Question : 
+ (Question *)parse:(NSDictionary *)questionDict;

@end
