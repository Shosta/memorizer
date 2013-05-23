//
//  AnswerTableViewCell.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 08/04/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "UILabel+Size.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation AnswerTableViewCell


#pragma mark - Play Sound

- (IBAction)playSound:(id)sender{
    SystemSoundID soundID;
    // NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], _soundFileName]];
    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:_soundFileName ofType:@"mp3"];
    
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(pewPewURL), &soundID);
    AudioServicesPlaySystemSound (soundID);
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
  
  UIFont *cellTextLabelFont = ANSWER_CELL_TEXT_FONT_MINOR_STYLE;
  UIColor *cellTextLabelColor = ANSWER_CELL_TEXT_COLOR_MINOR_STYLE;
  
  if (self.cellPresentationStyle == MajorStyle){
    cellTextLabelFont = ANSWER_CELL_TEXT_FONT_MAJOR_STYLE;
    cellTextLabelColor = ANSWER_CELL_TEXT_COLOR_MAJOR_STYLE;
  }
  
  [self configureTextLabelUIWithLabelFont:cellTextLabelFont
                               labelColor:cellTextLabelColor
                       labelTextAlignment:NSTextAlignmentLeft
                               labelWidth:kCellAnswerDefaultTextWidth
                      labelStartXPosition:kCellAnswerPaddingX
                      labelStartYPosition:kCellAnswerPaddingY];
}


#pragma mark - Animations

- (void)fadeInDescriptionImageView{
    if (self.descriptionImageView.alpha == 0) {
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:(void (^)(void)) ^{
                             self.descriptionImageView.alpha = 1.0;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void)fadeInPlaySoundButton{
    if (self.playSoundButton.alpha == 0) {
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:(void (^)(void)) ^{
                             self.playSoundButton.alpha = 1.0;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

@end
