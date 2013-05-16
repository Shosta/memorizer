//
//  HelpViewController.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 15/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "HelpViewController.h"
#import "GuiUtilities.h"

@interface HelpViewController ()

@end

@implementation HelpViewController


#pragma mark - Help View

/**
 @brief Add the help view on top of the current view.
 @author : Rémi Lavedrine
 @date : 10/09/2012
 @remarks : <#(optional)#>
 */
- (IBAction)addHelpSubview{
    [self.helpImageContainerScrollView setUserInteractionEnabled:YES];
  [GuiUtilities performUpdateAnimationForView:self.helpImageContainerScrollView];
}

/**
 @brief  the help view from its superview.
 @author : Rémi Lavedrine
 @date : 10/09/2012
 @remarks : <#(optional)#>
 */
- (IBAction)removeHelpSubviewFromSuperView{
    [self.helpImageContainerScrollView setUserInteractionEnabled:NO];
    // [self.helpImageContainerScrollView setAlpha:0.0];
  [GuiUtilities performHideAnimationForView:self.helpImageContainerScrollView];
}

/**
 @brief Add the help view on top of the current view or remove it if it's already visible.
 @author : Rémi Lavedrine
 @date : 16/05/2013
 @remarks : <#(optional)#>
 */
- (IBAction)addOrRemoveHelpSubview{
  if (self.helpImageContainerScrollView.alpha == 0) {
    [self addHelpSubview];
  }else{
    [self removeHelpSubviewFromSuperView];
  }
}


#pragma mark - Birth

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil helpImageViewName:(NSString *)helpImageViewName
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    UIImage *helpImage = [UIImage imageNamed:helpImageViewName];
    [self.helpImageView setImage:helpImage];
  }
  
  return self;
}


#pragma mark - View

- (void)addHelpButtonOnNavigationBar{
  /*UIButton *helpButton = [[UIButton alloc] init];
  [helpButton setTitle:@"i" forState:UIControlStateNormal];
  UIBarButtonItem *displayHelpButtonItem = [[UIBarButtonItem alloc] initWithCustomView:helpButton];*/
  
  UIBarButtonItem *displayHelpButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(addOrRemoveHelpSubview)];
  self.navigationItem.rightBarButtonItem = displayHelpButtonItem;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.helpImageView setBackgroundColor:[UIColor clearColor]];
  [self.helpImageView setUserInteractionEnabled:YES];
}


@end
