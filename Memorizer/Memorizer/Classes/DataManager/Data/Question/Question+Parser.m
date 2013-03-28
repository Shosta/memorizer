//
//  Question+Parser.m
//  Memorizer
//
//  Created by Rems on 21/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Question+Parser.h"

@implementation Question (Parser)


#pragma mark - Parsing

#define kStatementKey @"statement"
#define kAnswerKey @"answer"
#define kDescriptionKey @"description"
#define kImageKey @"image"
#define kVideoKey @"video"
#define kSoundKey @"sound"
/**
 @brief Create a Question object from an NSdictionary object returned from the parsing.
 @author : Rémi Lavedrine
 @date : 21/03/2013
 @remarks : <#(optional)#>
 */
+ (Question *)parse:(NSDictionary *)questionDict{
    Question *aQuestion = [[Question alloc] init];
    
    // 1. Parse the question.
    NSString *question = [questionDict objectForKey:kStatementKey];
    if (question != nil) {
        aQuestion.statement = question;
    }
    
    // 2. Parse the answer.
    NSString *answer = [questionDict objectForKey:kAnswerKey];
    if (answer != nil) {
        aQuestion.answer = answer;
    }
    
    // 3. Parse the description.
    NSString *description = [questionDict objectForKey:kDescriptionKey];
    if (answer != nil) {
        aQuestion.description = description;
    }
    
    // 4. Add the next présentation date to now.
    aQuestion.nextPresentationDate = [NSDate date];
    
    // 5. Add the image name if any.
    NSString *imageName = [questionDict objectForKey:kImageKey];
    if (answer != nil) {
        aQuestion.imageName = imageName;
    }
    
    // 6. Add the video name if any.
    NSString *videoName = [questionDict objectForKey:kVideoKey];
    if (answer != nil) {
        aQuestion.videoName = videoName;
    }
    
    // 7. Add the sound name if any.
    NSString *soundName = [questionDict objectForKey:kSoundKey];
    if (answer != nil) {
        aQuestion.soundName = soundName;
    }
    
    return aQuestion;
}

@end
