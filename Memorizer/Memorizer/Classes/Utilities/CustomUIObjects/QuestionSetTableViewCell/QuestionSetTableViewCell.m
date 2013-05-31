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

#pragma mark - Redraw

/**
 @brief Dynamically redesign the cell's UI if needed.
 @author : Rémi Lavedrine
 @date : 11/06/2012
 @remarks : <#(optional)#>
 */
- (void)layoutSubviews{
  [super layoutSubviews];
  
  int cellQuestionSetOriginY = kCellQuestionSetTitleOriginMajorY;
  if (_cellStyle == QuestionSetTableViewCellMinorStyle){
    cellQuestionSetOriginY = kCellQuestionSetTitleOriginMinorY;
  }
  
  [self configureTextLabelUIWithLabelFont:QUESTIONSET_CELL_TEXT_FONT
                               labelColor:QUESTIONSET_CELL_TEXT_COLOR
                       labelTextAlignment:NSTextAlignmentCenter
                               labelWidth:kCellQuestionSetDefaultTextWidth
                      labelStartXPosition:kCellQuestionSetPaddingX
                      labelStartYPosition:cellQuestionSetOriginY];
  
   self.questionSetInfoContainerView.center = CGPointMake(self.frame.size.width/2, cellQuestionSetOriginY + self.textLabel.frame.size.height + kCellQuestionSetPaddingY + self.questionSetInfoContainerView.frame.size.height/2);
  
}


#pragma mark - Accessors

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (void)setAnimatedImageAnimationFromPercent:(float)percent{
  
  int finalImageNumber = round(percent * 10);
  
  UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"questionSetPercent%d.png", finalImageNumber]];
  
  [self.questionSetProgressionAnimatedImageView setImage:image];
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
