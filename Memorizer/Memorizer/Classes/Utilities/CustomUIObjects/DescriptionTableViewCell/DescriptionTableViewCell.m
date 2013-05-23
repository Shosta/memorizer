//
//  DescriptionTableViewCell.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 09/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "DescriptionTableViewCell.h"
#import "UILabel+Size.h"

@implementation DescriptionTableViewCell


#pragma mark - Redraw

/**
 @brief Dynamically redesign the cell's UI if needed.
 @author : Rémi Lavedrine
 @date : 11/06/2012
 @remarks : <#(optional)#>
 */
- (void)layoutSubviews{
  [super layoutSubviews];
  
  [self configureTextLabelUIWithLabelFont:DESCRIPTION_CELL_TEXT_FONT
                               labelColor:DESCRIPTION_CELL_TEXT_COLOR
                       labelTextAlignment:NSTextAlignmentLeft
                               labelWidth:kCellDescriptionDefaultTextWidth
                      labelStartXPosition:kCellDescriptionPaddingX
                      labelStartYPosition:kCellDescriptionPaddingY];
}


@end
