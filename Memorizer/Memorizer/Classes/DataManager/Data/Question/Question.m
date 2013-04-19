//
//  Question.m
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Question.h"

@implementation Question

/**
 @brief Init method with a statement string, a answer string, a description string and a nextPresentationDate date.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
- (id)init{
    self = [super init];
    if (self) {
        self.statement = @"";
        self.answer = @"";
        self.description = @"";
        self.nextPresentationDate = [NSDate date];
        self.imageName = @"";
        self.videoName = @"";
        self.soundName = @"";
        self.userLastMemorizationLevel = NoMemorizationLevel;
    }
    
    return self;
}

@end
