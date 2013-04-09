//
//  StatementTableViewCell.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 09/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "StatementTableViewCell.h"
#import "UILabel+Size.h"

@implementation StatementTableViewCell


#pragma mark - Redraw

/**
 @brief Dynamically redesign the cell's UI if needed.
 @author : Rémi Lavedrine
 @date : 11/06/2012
 @remarks : <#(optional)#>
 */
- (void)layoutSubviews{
  [super layoutSubviews];
  
  [self configureTextLabelUIWithLabelFont:ANSWER_CELL_TEXT_FONT
                               labelColor:ANSWER_CELL_TEXT_COLOR
                       labelTextAlignment:NSTextAlignmentLeft
                               labelWidth:kCellStatementDefaultTextWidth
                      labelStartXPosition:kCellStatementPaddingX
                      labelStartYPosition:kCellStatementPaddingY];
}

@end
