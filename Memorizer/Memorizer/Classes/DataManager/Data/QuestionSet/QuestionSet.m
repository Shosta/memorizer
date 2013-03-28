//
//  QuestionSet.m
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSet.h"

@implementation QuestionSet

- (id)init{
    self = [super init];
    if (self) {
        self.questionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

@end
