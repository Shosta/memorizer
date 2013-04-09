//
//  NSString+LabelSize.m
//  MobinilAndMe
//
//  Created by Rémi LAVEDRINE on 11/06/12.
//  Copyright (c) 2012 France Telecom. All rights reserved.
//

#import "NSString+LabelSize.h"

@implementation NSString (LabelSize)

/**
 @brief Get the height of a text based on its font. 
 @author : Rémi Lavedrine
 @date : 11/06/2012
 @remarks : <#(optional)#>
 */
- (CGFloat)getTextHeightAtFont:(UIFont*)font forWidth:(CGFloat)width{
  CGSize size = CGSizeMake(width, 1000);// here is the trick.
  CGSize textSize = [self sizeWithFont:font constrainedToSize:size];
  
  return textSize.height;
}

@end
