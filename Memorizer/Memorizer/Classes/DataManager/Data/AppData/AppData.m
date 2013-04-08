//
//  AppData.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AppData.h"
#import "QuestionSet.h"
#import "AppData+Parser.h"
#import "AppData+Archiver.h"
// Singleton
static AppData * theAppData = nil;

@implementation AppData

#pragma mark - Read File


#pragma mark - Cache Data

/**
 @brief Get the HelpAndSupportNumbers.json file content according to the current chosen language. Return the default one if no language is chosen.
 @author : Rémi Lavedrine
 @date : 21/12/2012
 @remarks : <#(optional)#>
 */
- (NSString *)questionsFilePathForCurrentLanguage{
    NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"irregularVerbs.json" ofType:nil];
    
    return filePath;
}

/**
 @brief Refresh from file that contains the questions.
 @author : Rémi Lavedrine
 @date : 28/03/2013
 @remarks : <#(optional)#>
 */
- (void)refreshDataThroughFile{
    NSError *error=nil;
    NSString *filePath = [self questionsFilePathForCurrentLanguage];
    NSString *s = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSData *d = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMapped error:&error];
    if(error)
        OLLogDebug(@"%@",error);
    else
        OLLogDebug(@"%@",s);
    
    [self performSelectorOnMainThread:@selector(fetchedData:)
                           withObject:d waitUntilDone:YES];
    
}

/**
 @brief Load the Default Cache Data from the preembedded "JSON" file.
 @author : Rémi Lavedrine
 @date : 03/12/2012
 @remarks : <#(optional)#>
 */
- (void)loadDefaultCacheData{
    [self refreshDataThroughFile];
}


#pragma mark - Shared Instance

/**
 @brief Create or return the shared instance. Register to quit app notifications.
 @author : Rémi Lavedrine
 @date : 25/04/12
 @remarks : <#(optional)#>
 */
+ (AppData *)sharedInstance
{
    if(theAppData == nil)
    {
        theAppData = [AppData sharedInstanceDecodeArchiveFile:kArchiveFileName];
        if ( !theAppData ) {
            theAppData =[[AppData alloc] init];
            theAppData.questionSetsArray = [[NSMutableArray alloc] initWithCapacity:0];
            [theAppData loadDefaultCacheData];
        }
    }
    
    [self registerToNotifications];
    
    return theAppData;
}


#pragma mark - Archive notification

+ (void)registerToQuitAppNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(archive) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)unregisterToQuitAppNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}


#pragma mark - Notifications

+ (void)registerToNotifications{
    [self registerToQuitAppNotification];
}

- (void)unregisterToNotifications{
    [self unregisterToQuitAppNotification];
}

@end
