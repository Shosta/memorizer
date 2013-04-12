//
//  OLStatusView.h
//  OrangeEtMoi
//
//  Created by Rémi LAVEDRINE on 30/05/11.
//  Copyright 2011 Orange Labs. All rights reserved.
//
// Cette classe sert à présenter une vue décrivant des informations que l'utilisateur souhaite afficher en surimpression de la vue actuelle.
//

#import <UIKit/UIKit.h>
#import "OLStatusViewDelegate.h"


typedef enum {
  DownToUp,
  UpToDown
} TranslationDirection;

@interface OLStatusView : UIView {
  
  id delegate;
  
	UILabel *statusLabel;
	UIView *line;
	UIImageView *icon;
	
	int lineHeight;
	int xPadding;
	int yPadding;
	TranslationDirection translationDirection;
	
	UIColor *viewBackgroundColor;
	UIColor *statusTextColor;
	UIColor *lineBackgroundColor;
	
}


@property (assign) id delegate;

@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) UIView *line;
@property (nonatomic, retain) UIImageView *icon;

@property (nonatomic, retain) UIColor *viewBackgroundColor;
@property (nonatomic, retain) UIColor *statusTextColor;
@property (nonatomic, retain) UIColor *lineBackgroundColor;

#pragma mark -
#pragma mark Object life cycle
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection;
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont infoLabel:(NSString *)infoLabelText orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection;
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont icon:(UIImage *)image orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection;
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont activityIndicatorStyle:(UIActivityIndicatorViewStyle)style orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection;
- (void)addLabelWithLabelWidth:(int)labelWidth labelText:(NSString *)labelText textAlignmment:(UITextAlignment)textAlignment textFont:(UIFont *)textFont textColor:(UIColor *)textColor textXOrigin:(CGFloat)xOrigin;
- (void)addLineWithOrientation:(UIInterfaceOrientation)interfaceOrientation;

#pragma mark -
#pragma mark View life cycle
- (void)animateShowOnView:(UIView *)addToView;
- (void)translateView:(UIView *)view toX:(NSInteger)tx Y:(NSInteger)ty during:(NSTimeInterval)duration;
- (void)animateRemove;
- (void)remove;

-(void)showOnView:(UIView *)addToView;

@end


































