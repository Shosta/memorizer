//
//  AnswerTableViewCell.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 08/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "UILabel+Size.h"

@implementation AnswerTableViewCell


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
                               labelWidth:kCellAnswerDefaultTextWidth
                      labelStartXPosition:kCellAnswerPaddingX
                      labelStartYPosition:kCellAnswerPaddingY];
}


#pragma mark - Animations

- (void)fadeInDescriptionImageView{
  [UIView animateWithDuration:1.0
                        delay:0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:(void (^)(void)) ^{
                     self.descriptionImageView.alpha = 1.0;
                   }
                   completion:^(BOOL finished){
                   }];
}

@end
