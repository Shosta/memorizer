//
//  UINavigationController+Animations.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 16/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "UINavigationController+Animations.h"

#import <QuartzCore/QuartzCore.h>

@implementation UINavigationController (Animations)

- (void)pushViewControllerFromRight:(UIViewController *)viewController{
  CATransition* transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  transition.duration = 0.8f;
  transition.type =  @"reveal";
  transition.subtype = @"fromRight";
  
  [self.view.layer removeAllAnimations];
  [self.view.layer addAnimation:transition forKey:kCATransition];
  
  [self pushViewController:viewController animated:NO];
}

@end
