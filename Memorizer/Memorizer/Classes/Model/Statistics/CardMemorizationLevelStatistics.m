//
//  CardMemorizationLevelStatistics.m
//  Memorizer
//
//  Created by Rems on 07/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "CardMemorizationLevelStatistics.h"
#import "Question.h"

@implementation CardMemorizationLevelStatistics


- (void)fill{
    
    for (Question *question in self.questionsArray) {
        switch (question.userLastMemorizationLevel) {
            case MemorizationLevel1:
                self.level1Number = self.level1Number + 1;
                break;
                
            case MemorizationLevel2:
                self.level2Number = self.level2Number + 1;
                break;
                
            case MemorizationLevel3:
                self.level3Number = self.level3Number + 1;
                break;
                
            case MemorizationLevel4:
                self.level4Number = self.level4Number + 1;
                break;
                
            case MemorizationLevel5:
                self.level5Number = self.level5Number + 1;
                break;
                
            default:
                break;
        }
    }
    
    int questionCount = self.questionsArray.count;
    self.level1Percent = self.level1Number / questionCount * 100;
    self.level2Percent = self.level2Number / questionCount * 100;
    self.level3Percent = self.level3Number / questionCount * 100;
    self.level4Percent = self.level4Number / questionCount * 100;
    self.level5Percent = self.level5Number / questionCount * 100;
}


#pragma mark - Object

- (id)initWithQuestionsArray:(NSArray *)aQuestionSetArray{
    self = [super init];
    if (self){
        self.questionsArray = aQuestionSetArray;
        self.level1Number = 0;
        self.level2Number = 0;
        self.level3Number = 0;
        self.level4Number = 0;
        self.level5Number = 0;
        
        [self fill];
    }
    
    return self;
}

@end
