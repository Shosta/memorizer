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
  
  UIFont *cellTextLabelFont = STATEMENT_CELL_TEXT_FONT_MINOR_STYLE;
  UIColor *cellTextLabelColor = STATEMENT_CELL_TEXT_COLOR_MINOR_STYLE;
  
  if (self.cellPresentationStyle == MajorStyle){
    cellTextLabelFont = STATEMENT_CELL_TEXT_FONT_MAJOR_STYLE;
    cellTextLabelColor = STATEMENT_CELL_TEXT_COLOR_MAJOR_STYLE;
  }
  
  [self configureTextLabelUIWithLabelFont:cellTextLabelFont
                               labelColor:cellTextLabelColor
                       labelTextAlignment:NSTextAlignmentLeft
                               labelWidth:kCellStatementDefaultTextWidth
                      labelStartXPosition:kCellStatementPaddingX
                      labelStartYPosition:kCellStatementPaddingY];
}

@end
