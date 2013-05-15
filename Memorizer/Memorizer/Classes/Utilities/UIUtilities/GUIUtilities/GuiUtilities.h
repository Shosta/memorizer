//
//  GuiUtilities.h
//  OrangeEtMoi
//
//  Created by Rémi Groult on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

typedef enum orangeColors {
	DARK_GRAY = 0,
	LIGHT_GRAY,
	VERY_LIGHT_GRAY,
    WHITE,
    ORANGE,
} orangeColors;

@interface GuiUtilities : NSObject
+ (void)bounceHorizontally:(UIScrollView *)scrollView;
+ (void) performZoomAndAlphaAnimation:(UIView*)view;
+ (void) performUpdateAnimationForView:(UIView*)view;
+ (void) performHideAnimationForView:(UIView*)view;
+ (void) setBorderForView:(UIView*)aView;
+(UIColor*) getUIColorFor: (orangeColors)color;
+ (void) setTableViewSeparators:(UITableView*)tableView;
@end
