//
//  AppDelegate.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 05/03/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AppDelegate.h"
#import "AppData+Archiver.h"
#import "QuestionSetsTrainingSessionViewController.h"
#import "QuestionSetsMemorizationLevelViewController.h"

@implementation AppDelegate

#pragma mark - Appearance

- (void)setTableViewCellSelectionStyleAppearance{
  [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleGray];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (void)setNavigationTitleAppearance{
  NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                             TEXT_COLOR_MINOR_STYLE, UITextAttributeTextColor,
                                             [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)],
                                             UITextAttributeTextShadowOffset,
                                             nil];
  [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (void)setNavigationBarTintColorAppearance{
  [[UINavigationBar appearance] setTintColor:NAVIGATION_BAR_BACKGROUND_COLOR];
  // [[UINavigationBar appearance] setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationBar.png"]]];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (void)setBarButtonItemTintColorAppearance{
  [[UIBarButtonItem appearance] setTintColor:BAR_BUTTON_ITEM_COLOR];
  // [[UINavigationBar appearance] setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationBar.png"]]];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (void)setNavigationBarAppearance{
  [self setNavigationTitleAppearance];
  
  [self setNavigationBarTintColorAppearance];
  [self setBarButtonItemTintColorAppearance];
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : 10/04/2013
 @remarks : <#(optional)#>
 */
- (void)setApplicationAppearance{
  [self setNavigationBarAppearance];
}


#pragma mark - Help Views

/**
 @brief Sauvegarde la date à laquelle l'application a été lancée (lors de la mise en background) afin d'afficher les help views si cela fait plus de deux mois que l'application n'a pas été lancé.
 @author : Rémi Lavedrine
 @date : 26/05/2013
 @remarks : <#(optional)#>
 */
- (void)saveLastApplicationLaunchDate{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kQuestionSetHelpViewLastDisplayedDateKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kQuestionStatementHelpViewLastDisplayedDateKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kQuestionAnswerHelpViewLastDisplayedDateKey];
}


#pragma mark - Application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self.window makeKeyAndVisible];
  
  // Set appearance for all the defined controls.
  [self setApplicationAppearance];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveLastApplicationLaunchDate];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  [AppData archive];
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
