//
//  AppData+Archiver.h
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AppData.h"

@interface AppData (Archiver) <NSCoding>


//! Archive the current AppData singleton instance object and archive it in an archive file named "AppData.archive".
+ (BOOL)archive;

//! Unarchive an archive file and return the corresponding AppData object.
//! @param[in] fileName : A NSString ivar describing the name of the archive file that need to be decoded.
+ (AppData *)sharedInstanceDecodeArchiveFile:(NSString *)fileName;

//! Unarchive an archive file and return the corresponding AppData object.
//! @param[in] fileName : A NSString ivar describing the name of the archive file that need to be decoded.
- (AppData *)decodeArchiveFile:(NSString *)fileName;

//! Unarchive the "AppData.archive" archive file and set the result to the current AppData singleton instance object.
- (BOOL)unarchive;

@end
