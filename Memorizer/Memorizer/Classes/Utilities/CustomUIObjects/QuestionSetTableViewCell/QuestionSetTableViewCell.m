//
//  QuestionSetTableViewCell.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 10/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetTableViewCell.h"
#import "UIGaugeViewController.h"


@interface QuestionSetTableViewCell ()

@property (nonatomic) QuestionSetTableViewCellStyle cellStyle;
@property (retain, nonatomic) IBOutlet UIGaugeViewController *gaugeViewController;

@end


@implementation QuestionSetTableViewCell


#pragma mark - Object

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self != nil) {
    self.gaugeViewController = [[UIGaugeViewController alloc] initWithNibName:@"UIGaugeViewController" bundle:nil];
  }
  
  return self;
}


#pragma mark - Redraw

/**
 @brief Dynamically redesign the cell's UI if needed.
 @author : Rémi Lavedrine
 @date : 11/06/2012
 @remarks : <#(optional)#>
 */
- (void)layoutSubviews{
  [super layoutSubviews];
  int cellQuestionSetOriginY = kCellQuestionSetOriginMajorY;
  if (_cellStyle == QuestionSetTableViewCellMinorStyle){
    cellQuestionSetOriginY = kCellQuestionSetOriginMinorY;
  }else{
    [self.gaugeContainerView addSubview:self.gaugeViewController.view];
  }
  
  [self configureTextLabelUIWithLabelFont:QUESTIONSET_CELL_TEXT_FONT
                               labelColor:QUESTIONSET_CELL_TEXT_COLOR
                       labelTextAlignment:NSTextAlignmentLeft
                               labelWidth:kCellQuestionSetDefaultTextWidth
                      labelStartXPosition:kCellQuestionSetPaddingX
                      labelStartYPosition:cellQuestionSetOriginY];
}


#pragma mark - Accessors

/**
 @brief Set the percent for the gauge of the UIGaugeController.
 @author : Rémi Lavedrine
 @date : 06/11/2012
 @remarks : <#(optional)#>
 */
- (void)setGaugeProgress:(float)progress{
  [self.gaugeViewController setProgress:progress];
}


#pragma mark - Setters

/**
 @brief Change the position of the image.
 @author : Rémi Lavedrine
 @date : 11/05/2012
 @remarks : The "major" style displays all the information about the QuestionSet in order to display a MemorizationLevel QuestionSet.
 The "minor" style displays all the information about the QuestionSet in order to display a simple QuestionSet
 */
- (void)setCellStyle:(QuestionSetTableViewCellStyle)style{
  _cellStyle = style;
}

@end
