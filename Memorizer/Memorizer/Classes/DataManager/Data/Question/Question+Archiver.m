//
//  Question+Archiver.m
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Question+Archiver.h"

@implementation Question (Archiver)


#pragma mark - Object

/**
 @brief Init method with a statement string, a answer string, a description string and a nextPresentationDate date.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
- (id)initWithStatement:(NSString *)aStatement
                 answer:(NSString *)aAnswer
            description:(NSString *)aDescription
andNextPresentationDate:(NSDate *)aNextPresentationDate{
    self = [super init];
    if (self) {
        self.statement = aStatement;
        self.answer = aAnswer;
        self.description = aDescription;
        self.nextPresentationDate = aNextPresentationDate;
    }
    
    return self;
}


#pragma mark - Archiving

#define kStatementKey @"statement"
#define kAnswerKey @"answer"
#define kDescriptionKey @"description"
#define kNextPresentationDateKey @"nextPresentationDate"

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.statement forKey:kStatementKey];
    [encoder encodeObject:self.answer forKey:kAnswerKey];
    [encoder encodeObject:self.description forKey:kDescriptionKey];
    [encoder encodeObject:self.nextPresentationDate forKey:kNextPresentationDateKey];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (id)initWithCoder:(NSCoder *)decoder {
    NSString *s = [decoder decodeObjectForKey:kStatementKey];
    NSString *a = [decoder decodeObjectForKey:kAnswerKey];
    NSString *d = [decoder decodeObjectForKey:kDescriptionKey];
    NSDate *n = [decoder decodeObjectForKey:kNextPresentationDateKey];
    
    return [self initWithStatement:s
                            answer:a
                       description:d
           andNextPresentationDate:n];
}


@end
