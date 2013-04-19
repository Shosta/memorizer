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
   nextPresentationDate:(NSDate *)aNextPresentationDate
              imageName:(NSString *)aImageName
              videoName:(NSString *)aVideoName
              soundName:(NSString *)aSoundName
userLastMemorizationLevel:(MemorizationLevel)aUserLastMemorizationLevel{
    self = [super init];
    if (self) {
        self.statement = aStatement;
        self.answer = aAnswer;
        self.description = aDescription;
        self.nextPresentationDate = aNextPresentationDate;
        self.imageName = aImageName;
        self.videoName = aVideoName;
        self.soundName = aSoundName;
        self.userLastMemorizationLevel = aUserLastMemorizationLevel;
    }
    
    return self;
}


#pragma mark - Archiving

#define                 kStatementKey @"statement"
#define                    kAnswerKey @"answer"
#define               kDescriptionKey @"description"
#define      kNextPresentationDateKey @"nextPresentationDate"
#define                     kImageKey @"image"
#define                     kVideoKey @"video"
#define                     kSoundKey @"sound"
#define kUserLastMemorizationLevelKey @"userLastMemorizationLevel"
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
    [encoder encodeObject:self.imageName forKey:kImageKey];
    [encoder encodeObject:self.videoName forKey:kVideoKey];
    [encoder encodeObject:self.soundName forKey:kSoundKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.userLastMemorizationLevel] forKey:kUserLastMemorizationLevelKey];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (id)initWithCoder:(NSCoder *)decoder {
    NSString  *s = [decoder decodeObjectForKey:kStatementKey];
    NSString  *a = [decoder decodeObjectForKey:kAnswerKey];
    NSString  *d = [decoder decodeObjectForKey:kDescriptionKey];
    NSDate    *n = [decoder decodeObjectForKey:kNextPresentationDateKey];
    NSString  *i = [decoder decodeObjectForKey:kImageKey];
    NSString  *v = [decoder decodeObjectForKey:kVideoKey];
    NSString *sd = [decoder decodeObjectForKey:kSoundKey];
    int     ulml = [[decoder decodeObjectForKey:kUserLastMemorizationLevelKey] intValue];
    
    return [self initWithStatement:s
                            answer:a
                       description:d
              nextPresentationDate:n
                         imageName:i
                         videoName:v
                         soundName:sd
         userLastMemorizationLevel:ulml];
}

@end
