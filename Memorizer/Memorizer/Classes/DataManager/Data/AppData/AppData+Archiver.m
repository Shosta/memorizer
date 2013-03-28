//
//  AppData+Archiver.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AppData+Archiver.h"

@implementation AppData (Archiver)


#pragma mark - Archive management

/**
 @brief Archive an object to an archive file.
 @author : Rémi Lavedrine
 @date : 27/04/2012
 @remarks : <#(optional)#>
 */
+ (BOOL)archiveObject:(AppData *)appData toArchiveFile:(NSString *)archiveFileName{
    NSString *archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:archiveFileName];
    BOOL result = [NSKeyedArchiver archiveRootObject:appData toFile:archivePath];
    
    return result;
}

/**
 @brief Archive the current AppData singleton instance object and archive it in an archive file named "AppData.archive".
 @author : Rémi Lavedrine
 @date : 27/04/2012
 @remarks : <#(optional)#>
 */
+ (BOOL)archive{
    return [self archiveObject:[AppData sharedInstance] toArchiveFile:kArchiveFileName];
}

/**
 @brief Unarchive an archive file and return the corresponding AppData object.
 @author : Rémi Lavedrine
 @date : 27/04/2012
 @remarks : This function is accessible from the shared instance singleton.
 */
+ (AppData *)sharedInstanceDecodeArchiveFile:(NSString *)fileName{
    NSFileManager *manager = [[NSFileManager alloc] init];
    AppData *appData = nil;
    NSString *archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    if ( [manager fileExistsAtPath:archivePath] ) {
        appData = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
        // OLLogDebug(@"%@", [appData describeObject]);
    }
    
    return appData;
}

/**
 @brief Unarchive an archive file and return the corresponding AppData object.
 @author : Rémi Lavedrine
 @date : 27/04/2012
 @remarks : <#(optional)#>
 */
- (AppData *)decodeArchiveFile:(NSString *)fileName{
    NSFileManager *manager = [[NSFileManager alloc] init];
    AppData *appData = nil;
    NSString *archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    if ( [manager fileExistsAtPath:archivePath] ) {
        appData = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
        // OLLogDebug(@"%@", [appData describeObject]);
    }
    
    return appData;
}

/**
 @brief Unarchive the "AppData.archive" archive file and set the result to the current AppData singleton instance object.
 @author : Rémi Lavedrine
 @date : 27/04/2012
 @remarks : <#(optional)#>
 */
- (BOOL)unarchive{
    AppData *appData = [self decodeArchiveFile:kArchiveFileName];
    if ( appData ) {
        // OLLogDebug(@"%@", [appData describeObject]);
        return YES;
    }
    
    return NO;
}


#pragma mark - Object life cycle

/**
 @brief Init method with an update object, an internationalization object and a metadata object
 @author : Rémi Lavedrine
 @date : 26/04/2012
 @remarks : <#(optional)#>
 */
- (id)initWithQuestionSetsArray:(NSMutableArray *)aQuestionSetsArray {
    self = [super init];
    if (self) {
        self.questionSetsArray = aQuestionSetsArray;
    }
    
    return self;
}


#pragma mark - NSCoding protocol

//! Define the keys for the object that will need to be encoded or decoded.
#define kQuestionSetsArrayKey @"questionSetsArray"
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.questionSetsArray forKey:kQuestionSetsArrayKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSMutableArray *q = [decoder decodeObjectForKey:kQuestionSetsArrayKey];
    
    return [self initWithQuestionSetsArray:q];
}

@end
