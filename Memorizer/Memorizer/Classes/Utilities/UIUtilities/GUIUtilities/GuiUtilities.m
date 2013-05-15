//
//  GuiUtilities.m
//  OrangeEtMoi
//
//  Created by Rémi Groult on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuiUtilities.h"
#import <QuartzCore/QuartzCore.h>

@implementation GuiUtilities

// This method begins the first animation.
+ (void)bounceHorizontally:(UIScrollView *)scrollView
{
  CGPoint newContentOffset = CGPointMake(scrollView.contentOffset.x + 30, scrollView.contentOffset.y);
  
  [UIView animateWithDuration:1.0 animations:^{
    [scrollView setContentOffset:newContentOffset animated:YES];
    
    // Commit the changes
    [UIView commitAnimations];
  }completion:^(BOOL finished){
    [UIView animateWithDuration:1.0 animations:^{
      CGAffineTransform transform  = CGAffineTransformIdentity;
      scrollView.transform = transform;
      
      // Commit the changes
      [UIView commitAnimations];
    }];
    
  }];
}

+ (void) performZoomAndAlphaAnimation:(UIView*)view
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.7];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
  [UIView setAnimationDelegate:view];
  
  view.transform = CGAffineTransformMakeScale(1.5, 1.5);
  view.alpha = .0;
  
  [UIView commitAnimations];
}

+ (void) performUpdateAnimationForView:(UIView*)view
{
  view.alpha = .0;
  //view.transform = CGAffineTransformMakeScale(0, 1.0);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.7];
  view.alpha = 1;
  
  [UIView commitAnimations];
}

+ (void) performHideAnimationForView:(UIView*)view
{
  view.alpha = 1;
  //view.transform = CGAffineTransformMakeScale(0, 1.0);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.7];
  view.alpha = .0;
  
  [UIView commitAnimations];
}

+ (void) performUpdateAnimation4ForView:(UIView*)view
{
  view.alpha = .0;
  view.transform = CGAffineTransformMakeRotation(3.14/2);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.7];
  view.transform = CGAffineTransformMakeRotation(0);
  view.alpha = 1;
  
  [UIView commitAnimations];
}

+ (void) performUpdateAnimationOLdForView:(UIView*)view
{
  view.alpha = .0;
  //view.transform = CGAffineTransformMakeScale(0, 1.0);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.7];
  [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:YES];
  //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  
  //view.transform = CGAffineTransformMakeScale(1.0, 1.0);
  view.alpha = 1.0;
  
  [UIView commitAnimations];
}

+ (void) performUpdateAnimation2ForView:(UIView*)view
{
  int currentHeight=view.frame.size.height;
  CGRect frame=view.frame;
  frame.size.height=0;
  view.frame=frame;
  //view.alpha = .0;
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3];
  //view.alpha = 1;
  // view.transform = CGAffineTransformMakeScale(1.2, 1.2);
  // view.transform = CGAffineTransformMakeScale(1.0, 1.0);
  frame.size.height=currentHeight;
  view.frame=frame;
  
  [UIView commitAnimations];
}

+ (void) setBorderForView:(UIView*)aView {
  aView.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
  aView.layer.borderWidth = 1;
}

+ (UIColor*) getUIColorFor: (orangeColors)color{
  switch (color) {
    case DARK_GRAY:
      return UIColorFromRGB(0x333333);
      
    case LIGHT_GRAY:
      return UIColorFromRGB(0x666666);
      
    case WHITE:
      return UIColorFromRGB(0xFFFFFF);
      
    case VERY_LIGHT_GRAY:
      return UIColorFromRGB(0xDCDCDC);
      
    case ORANGE:
      return UIColorFromRGB(0xFF6600);
  }
  return nil;
}

+ (void)setTableViewSeparators:(UITableView*)tableView
{
  tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  tableView.separatorColor = [GuiUtilities getUIColorFor:VERY_LIGHT_GRAY];
  UIView* footer = [[UIView alloc] initWithFrame:CGRectZero];
  tableView.tableFooterView = footer;
}

@end
