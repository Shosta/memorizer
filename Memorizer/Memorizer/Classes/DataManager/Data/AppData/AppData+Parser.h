//
//  AppData+Parser.h
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AppData.h"

@interface AppData (Parser)

//! Parse the data from the File.
//! @param [in] data : The NSData object that has to be parsed.
- (void)fetchedData:(NSData *)data;

@end
