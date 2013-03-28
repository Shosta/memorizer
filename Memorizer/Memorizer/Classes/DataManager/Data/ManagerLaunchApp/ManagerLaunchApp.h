//
//  ManagerLaunchApp.h
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerLaunchApp : NSObject


#pragma mark - Public methods
//! Singleton method.
+ (ManagerLaunchApp *)sharedInstance;

#pragma mark - Refresh AppData
//! Refresh the AppData from the network when the user first launchs the application.
- (void)refreshData;

@end
