//
//  AutoResizeLabelTableViewCell.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 09/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AutoResizeLabelTableViewCell.h"
#import "UILabel+Size.h"

@implementation AutoResizeLabelTableViewCell


#pragma mark - Object

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self != nil) {
    // UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellBackgroundTemplateColor.png"]];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.cellPresentationStyle = MinorStyle;
  }
  
  return self;
}


#pragma mark - Redraw

/**
 @brief Dynamically redesign the cell's left label (TextLabel) UI if needed.
 @author : Rémi Lavedrine
 @date : 11/06/2012
 @remarks : <#(optional)#>
 */
- (void)configureTextLabelUIWithLabelFont:(UIFont *)font
                               labelColor:(UIColor *)color
                       labelTextAlignment:(NSTextAlignment)textAlignment
                               labelWidth:(int)width
                      labelStartXPosition:(int)startXPosition
                      labelStartYPosition:(int)startYPosition{
  
  [self.textLabel setFont:font];
  [self.textLabel setTextColor:color];
  [self.textLabel setTextAlignment:textAlignment];
  [self.textLabel setUpMultiLineFrameBasedOnWidth:width
                               withStartXPosition:startXPosition
                               withStartYPosition:startYPosition];
}

@end
