//
//  OLStatusViewDelegate.h
//  OLStatusBarDemo
//
//  Created by Rémi LAVEDRINE on 08/08/11.
//  Copyright 2011 Orange Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OLStatusViewDelegate 

@optional 

- (void)statusViewWillAppear;
- (void)statusViewWillDisappear;

- (void)statusViewDidAppear;
- (void)statusViewDidDisappear;

@end
