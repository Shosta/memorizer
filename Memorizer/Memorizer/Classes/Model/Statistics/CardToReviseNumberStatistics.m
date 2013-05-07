//
//  CardToReviseNumberStatistics.m
//  Memorizer
//
//  Created by Rems on 07/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "CardToReviseNumberStatistics.h"
#import "NSDate+AddDays.h"
#import "Question.h"

@implementation CardToReviseNumberStatistics

- (int)differenceInDaysBeetween:(NSDate *)firstDate and:(NSDate *)secondDate{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd MM yyyy"]; // here we cut time part
    NSString *todayString = [df stringFromDate:firstDate];
    NSString *targetDateString = [df stringFromDate:secondDate];
    NSTimeInterval time = [[df dateFromString:targetDateString] timeIntervalSinceDate:[df dateFromString:todayString]];
    
    int differenceInDays = time / 60 / 60/ 24;
    
    return differenceInDays;
}

- (void)fill{
    NSDate *today = [NSDate date];
    
    for (Question *question in self.questionsArray) {
        int numberOfDays = [self differenceInDaysBeetween:today and:question.nextPresentationDate];
        switch (numberOfDays) {
            case 0:
                self.cardNumberToday = self.cardNumberToday + 1;
                break;
                
            case 1:
                self.cardNumberTomorrow = self.cardNumberTomorrow + 1;
                break;
                
            case 2:
                self.cardNumberInTwoDays = self.cardNumberInTwoDays + 1;
                break;
                
            case 3:
                self.cardNumberInThreeDays = self.cardNumberInThreeDays + 1;
                break;
                
            case 4:
                self.cardNumberInFourDays = self.cardNumberInFourDays + 1;
                break;
                
            default:
                if (numberOfDays < 0) {
                    self.cardNumberToday = self.cardNumberToday + 1;
                }
                break;
        }
    }
    
}


#pragma mark - Object

- (id)initWithQuestionsArray:(NSArray *)aQuestionSetArray{
    self = [super init];
    if (self){
        self.questionsArray = aQuestionSetArray;
        self.cardNumberToday = 0;
        self.cardNumberTomorrow = 0;
        self.cardNumberInTwoDays = 0;
        self.cardNumberInThreeDays = 0;
        self.cardNumberInFourDays = 0;
        
        [self fill];
    }
    
    return self;
}

@end
