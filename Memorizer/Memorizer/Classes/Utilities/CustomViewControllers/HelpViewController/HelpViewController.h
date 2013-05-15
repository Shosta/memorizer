//
//  HelpViewController.h
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 15/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *helpImageView;


#pragma mark - Birth

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil helpImageViewName:(NSString *)helpImageViewName;

- (void)addHelpButtonOnNavigationBar;


@end
