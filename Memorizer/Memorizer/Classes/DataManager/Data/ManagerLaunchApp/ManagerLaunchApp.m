//
//  ManagerLaunchApp.m
//  Memorizer
//
//  Created by Rems on 28/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "ManagerLaunchApp.h"
#import "AppData.h"

// Singleton
static ManagerLaunchApp * theManagerLaunchApp = nil;
@implementation ManagerLaunchApp


#pragma mark - Refresh

- (void)refreshData{
    // [APP_DATA refreshData];
}


#pragma mark - Refresh notification

+ (void)registerToEnterFromBackgroundAppNotification{
    [[NSNotificationCenter defaultCenter] addObserver:MANAGER_LAUNCH_APP selector:@selector(refreshData) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)unregisterToEnterFromBackgroundAppNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:MANAGER_LAUNCH_APP name:UIApplicationWillEnterForegroundNotification object:nil];
}


#pragma mark - Notifications

+ (void)registerToNotifications{
    [self registerToEnterFromBackgroundAppNotification];
}

- (void)unregisterToNotifications{
    [self unregisterToEnterFromBackgroundAppNotification];
}


#pragma mark - SharedInstance

/**
 @brief Create or return the shared instance. Register to quit app notifications.
 @author : Rémi Lavedrine
 @date : 25/04/12
 @remarks : <#(optional)#>
 */
+ (ManagerLaunchApp *)sharedInstance
{
    if(theManagerLaunchApp == nil)
    {
        if ( !theManagerLaunchApp ) {
            theManagerLaunchApp = [[ManagerLaunchApp alloc] init];
        }
        
        [self registerToNotifications];
    }
    
    return theManagerLaunchApp;
}

@end
