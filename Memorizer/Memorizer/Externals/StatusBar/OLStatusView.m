//
//  OLStatusView.m
//  OrangeEtMoi
//
//  Created by Rémi LAVEDRINE on 30/05/11.
//  Copyright 2011 Orange Labs. All rights reserved.
//

#import "OLStatusView.h"
#import "UILabel+Size.h"

@interface OLStatusView (Private)

- (void)showOnViewUpToDown:(UIView *)addToView;
- (void)showOnViewDownToUp:(UIView *)addToView;

- (void)showOnTopOfView:(UIView *)addToView;
- (void)showOnBottomOfView:(UIView *)addToView;

@end

@implementation OLStatusView (Private)

- (void)showOnViewUpToDown:(UIView *)addToView{
  [self setTransform:CGAffineTransformIdentity];
  [self setFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
  [addToView addSubview:self];
}

- (void)showOnViewDownToUp:(UIView *)addToView{
  [self setTransform:CGAffineTransformIdentity];
  [self setFrame:CGRectMake(0, addToView.frame.size.height, self.frame.size.width, self.frame.size.height)];
  [addToView addSubview:self];
}

- (void)showOnTopOfView:(UIView *)addToView{
  [self setTransform:CGAffineTransformIdentity];
  [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  [addToView addSubview:self];
}

- (void)showOnBottomOfView:(UIView *)addToView{
  [self setTransform:CGAffineTransformIdentity];
  [self setFrame:CGRectMake(0, addToView.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height)];
  [addToView addSubview:self];
}

@end






@implementation OLStatusView

@synthesize delegate;
@synthesize statusLabel;
@synthesize line;
@synthesize icon;
@synthesize viewBackgroundColor;
@synthesize statusTextColor;
@synthesize lineBackgroundColor;


#pragma mark -
#pragma mark Object life cycle

- (id)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code.
	}
	return self;
}

#define VIEW_WIDTH_PORTRAIT 320
#define VIEW_WIDTH_LANDSCAPE 480
#define LINE_HEIGHT 3
#define PADDING 10
/*
 Constructeur de la vue permettant d'afficher un statut.
 @In : (NSString *)labelText : Le texte du label de la statusView.
 @In : (UIFont *)textFont : La font du texte du label.
 @In : (UIInterfaceOrientation)interfaceOrientation : L'orientation dans laquelle va apparaître la statusView.
 @In : (TranslationDirection)a_translationDirection : La direction que l'on va utiliser pour l'animation d'apparition de la vue.
 @Out : (OLStatusView *) : La statusView.
 @author : Rémi Lavedrine
 @date : 31/05/2011
 @remarks : (facultatif) 
 */
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection{
	lineHeight = LINE_HEIGHT;
	xPadding = PADDING;
	yPadding = PADDING;
	translationDirection = a_translationDirection;
	
	viewBackgroundColor = [UIColor blackColor];
	statusTextColor = [UIColor whiteColor];
	lineBackgroundColor = [UIColor orangeColor];
	
	
	if (!(self = [super initWithFrame:CGRectZero]))
		return nil;
	
	int labelWidth = 0;
	if (interfaceOrientation == UIInterfaceOrientationPortrait) {
		labelWidth = VIEW_WIDTH_PORTRAIT - xPadding - xPadding;
	}else if ( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
		labelWidth = VIEW_WIDTH_LANDSCAPE - xPadding - xPadding;
	}
	[self addLabelWithLabelWidth:labelWidth labelText:labelText textAlignmment:NSTextAlignmentLeft textFont:textFont textColor:statusTextColor textXOrigin:PADDING];
	
	[self addLineWithOrientation:interfaceOrientation];
	
	return self;
}

/*
 Constructeur de la vue permettant d'afficher un statut.
 @In : (NSString *)labelText : Le texte du label de la statusView.
 @In : (UIFont *)textFont : La font du texte du label.
 @in : (NSString *)infoLabelText : Le texte du label que l'on placer à gauche du label de status.
 @In : (UIInterfaceOrientation)interfaceOrientation : L'orientation dans laquelle va apparaître la statusView.
 @In : (TranslationDirection)a_translationDirection : La direction que l'on va utiliser pour l'animation d'apparition de la vue.
 @Out : (OLStatusView *) : La statusView.
 @author : Rémi Lavedrine
 @date : 01/06/2011
 @remarks : (facultatif) 
 */
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont infoLabel:(NSString *)infoLabelText orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection{
	lineHeight = LINE_HEIGHT;
	xPadding = PADDING;
	yPadding = PADDING;
	translationDirection = a_translationDirection;
	
	viewBackgroundColor = [UIColor blackColor];
	statusTextColor = [UIColor whiteColor];
	lineBackgroundColor = [UIColor orangeColor];
	
	
	if (!(self = [super initWithFrame:CGRectZero]))
		return nil;
	
	int labelWidth = 0;
	int infoLabelWidth = 50;
	if (interfaceOrientation == UIInterfaceOrientationPortrait) {
		labelWidth = VIEW_WIDTH_PORTRAIT - xPadding - infoLabelWidth - xPadding;
	}else if ( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
		labelWidth = VIEW_WIDTH_LANDSCAPE - xPadding - infoLabelWidth - xPadding;
	}
	[self addLabelWithLabelWidth:infoLabelWidth labelText:infoLabelText textAlignmment:NSTextAlignmentLeft textFont:[UIFont fontWithName: @"Helvetica-Bold" size:14] textColor:[UIColor orangeColor] textXOrigin:PADDING];
	[self addLabelWithLabelWidth:labelWidth labelText:labelText textAlignmment:NSTextAlignmentLeft textFont:textFont textColor:statusTextColor textXOrigin:PADDING + infoLabelWidth + 5];
	
	[self addLineWithOrientation:interfaceOrientation];
	
	return self;
}

#define ICON_WIDTH 25
#define ICON_HEIGHT 25
/*
 Constructeur de la vue permettant d'afficher un statut avec une image sur la gauche du statut.
 @In : (NSString *)labelText : Le texte du label de la statusView.
 @In : (UIFont *)textFont : La font du texte du label.
 @In : (UIImage *)image : L'image que l'on place à la gauche du texte dans la statusView.
 @In : (UIInterfaceOrientation)interfaceOrientation : L'orientation dans laquelle va apparaître la statusView.
 @In : (TranslationDirection)a_translationDirection : La direction que l'on va utiliser pour l'animation d'apparition de la vue.
 @Out : (OLStatusView *) : La statusView.
 @author : Rémi Lavedrine
 @date : 01/06/2011
 @remarks : (facultatif) 
 */
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont icon:(UIImage *)image orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection{
	lineHeight = LINE_HEIGHT;
	xPadding = PADDING;
	yPadding = PADDING;
	translationDirection = a_translationDirection;
	
	viewBackgroundColor = [UIColor blackColor];
	statusTextColor = [UIColor whiteColor];
	lineBackgroundColor = [UIColor orangeColor];
	
	if (!(self = [super initWithFrame:CGRectZero]))
		return nil;
	
	int labelWidth = 0;
	if (interfaceOrientation == UIInterfaceOrientationPortrait) {
		labelWidth = VIEW_WIDTH_PORTRAIT - xPadding - ICON_WIDTH - xPadding;
	}else if ( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
		labelWidth = VIEW_WIDTH_LANDSCAPE - xPadding - ICON_WIDTH - xPadding;
	}
	// On ajoute l'image.
	icon = [[UIImageView alloc] initWithImage:image];
	[icon	setFrame:CGRectMake(xPadding, yPadding, ICON_WIDTH, ICON_HEIGHT)];
	[self addSubview:icon];
	[self addLabelWithLabelWidth:labelWidth labelText:labelText textAlignmment:NSTextAlignmentLeft textFont:textFont textColor:statusTextColor textXOrigin:PADDING + ICON_WIDTH + 5];
	
	[self addLineWithOrientation:interfaceOrientation];
	
	return self;
}

#define ICON_WIDTH 25
#define ICON_HEIGHT 25
/*
 Constructeur de la vue permettant d'afficher un statut avec un spinner sur la gauche du label.
 @In : (NSString *)labelText : Le texte du label de la statusView.
 @In : (UIFont *)textFont : La font du texte du label.
 @In : (UIActivityIndicatorViewStyle)style : Le style du UIActivityIndicatorViewStyle que l'on va afficher.
 @In : (UIInterfaceOrientation)interfaceOrientation : L'orientation dans laquelle va apparaître la statusView.
 @In : (TranslationDirection)a_translationDirection : La direction que l'on va utiliser pour l'animation d'apparition de la vue.
 @Out : (OLStatusView *) : La statusView.
 @author : Rémi Lavedrine
 @date : 01/06/2011
 @remarks : (facultatif) 
 */
- (OLStatusView *)initWithStatusLabel:(NSString *)labelText textFont:(UIFont *)textFont activityIndicatorStyle:(UIActivityIndicatorViewStyle)style orientation:(UIInterfaceOrientation)interfaceOrientation translationDirection:(TranslationDirection)a_translationDirection{
	lineHeight = LINE_HEIGHT;
	xPadding = PADDING;
	yPadding = PADDING;
	translationDirection = a_translationDirection;
	
	viewBackgroundColor = [UIColor blackColor];
	statusTextColor = [UIColor whiteColor];
	lineBackgroundColor = [UIColor orangeColor];
	
	if (!(self = [super initWithFrame:CGRectZero]))
		return nil;
	
	int labelWidth = 0;
	if (interfaceOrientation == UIInterfaceOrientationPortrait) {
		labelWidth = VIEW_WIDTH_PORTRAIT - xPadding - ICON_WIDTH - xPadding;
	}else if ( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
		labelWidth = VIEW_WIDTH_LANDSCAPE - xPadding - ICON_WIDTH - xPadding;
	}
	// On ajoute l'activity indicator.
	UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
	[indicatorView setFrame:CGRectMake(xPadding, yPadding, ICON_WIDTH, ICON_HEIGHT)];
	[indicatorView startAnimating];
	[self addSubview:indicatorView];
	[self addLabelWithLabelWidth:labelWidth labelText:labelText textAlignmment:NSTextAlignmentRight textFont:textFont textColor:statusTextColor textXOrigin:PADDING + ICON_WIDTH + 5];
	
	[self addLineWithOrientation:interfaceOrientation];
	
	return self;
}

/*
 Ajoute le label contenant l'information du statusLabel.
 @In : (int)labelWidth : La largeur que l'on souhaite donner au Label dans la vue.
 @In : (NSString *)labelText : Le texte du label que l'on ajoute.
 @In : (UITextAlignment)textAlignment : L'alignement du texte dans le label.
 @In : (UIFont *)textFont : La font du texte du label.
 @In : (UIColor *)textColor : La couleur du label.
 @In : (CGFloat)xOrigin : La position en X de l'origine du label dans la vue.
 @author : Rémi Lavedrine
 @date : 01/06/2011
 @remarks : (facultatif)
 */
- (void)addLabelWithLabelWidth:(int)labelWidth labelText:(NSString *)labelText textAlignmment:(UITextAlignment)textAlignment textFont:(UIFont *)textFont textColor:(UIColor *)textColor textXOrigin:(CGFloat)xOrigin{
	
	CGFloat height = 0;
	
	statusLabel = [[UILabel alloc] init];
	[statusLabel setText:labelText];
	[statusLabel setFont:textFont];
	height = [statusLabel getHeightBasedOnWidth:labelWidth];
	[statusLabel setUpMultiLineFrameBasedOnWidth:labelWidth withStartXPosition:0];
	[statusLabel setTextAlignment:textAlignment];
	[statusLabel setFrame:CGRectMake(xOrigin, yPadding, labelWidth, height)];
	
	[self setFrame:CGRectMake(0, 0, VIEW_WIDTH_LANDSCAPE, height + yPadding + yPadding)];
	[self setBackgroundColor:viewBackgroundColor];
	
	[self addSubview:statusLabel];
	
	[statusLabel setBackgroundColor:[UIColor clearColor]];
	[statusLabel setTextColor:textColor];
}

/*
 Ajoute la ligne en haut ou en bas de la vue en fonction de l'interface et de la direction de l'animation.
 @In : (UIInterfaceOrientation)interfaceOrientation : L'orientation de la vue.
 @author : Rémi Lavedrine
 @date : 01/06/2011
 @remarks : (facultatif)
 */
- (void)addLineWithOrientation:(UIInterfaceOrientation)interfaceOrientation{
	
	// On ajoute une ligne Orange en haut ou en bas de la vue.
	if ( translationDirection == UpToDown ) {
		
		if (interfaceOrientation == UIInterfaceOrientationPortrait) {
			line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - lineHeight, VIEW_WIDTH_PORTRAIT, lineHeight)];
		}else if ( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
			line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - lineHeight, VIEW_WIDTH_LANDSCAPE, lineHeight)];
		}
		
	}else if ( translationDirection == DownToUp ) {
		
		if (interfaceOrientation == UIInterfaceOrientationPortrait) {
			line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH_PORTRAIT, lineHeight)];
		}else if ( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
			line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH_LANDSCAPE, lineHeight)];
		}
		
	}
	
	[line setBackgroundColor:lineBackgroundColor];
	[self addSubview:line];
	
}


#pragma mark -
#pragma mark View life cycle

#define STATUS_VIEW_ACTION_DELAY 1.0
/*
 Anime l'apparition de la vue.
 @In : (UIView *)addToView : La vue à laquelle on souhaite ajouter la statusView.
 @author : Rémi Lavedrine
 @date : 31/05/2011
 @remarks : (facultatif)
 */
- (void)animateShowOnView:(UIView *)addToView {
  
  if ([delegate respondsToSelector:@selector(statusViewWillAppear)]) {
    [delegate performSelector:@selector(statusViewWillAppear) withObject:nil];
  }
  
  
  float delay = STATUS_VIEW_ACTION_DELAY;
  
	if ( translationDirection == UpToDown ) {
		// On place la vue à "-height - PADDING - PADDING" afin de pouvoir faire la translation en Y vers le bas.
    [self showOnViewUpToDown:addToView];
		[self translateView:self toX:0 Y:self.frame.size.height during:delay];
		
	}else if ( translationDirection == DownToUp ) {
		// On place la vue à "height + PADDING + PADDING" afin de pouvoir faire la translation en Y vers le haut.
		[self showOnViewDownToUp:addToView];
		[self translateView:self toX:0 Y:-self.frame.size.height during:delay];
    
	}
  
  
  if ([delegate respondsToSelector:@selector(statusViewDidAppear)]) {
    [delegate performSelector:@selector(statusViewDidAppear) withObject:nil afterDelay:delay];
  }
	
}

- (void)translateView:(UIView *)view toX:(NSInteger)tx Y:(NSInteger)ty during:(NSTimeInterval)duration{
  // Setup the animation
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:duration];
  [UIView setAnimationBeginsFromCurrentState:YES];
	
  // The transform matrix
  CGAffineTransform transform = CGAffineTransformMakeTranslation(tx, ty);
  view.transform = transform;
	
  // Commit the changes
  [UIView commitAnimations];
  
}

-(void)showOnView:(UIView *)addToView{
  
  if ([delegate respondsToSelector:@selector(statusViewWillAppear)]) {
    [delegate performSelector:@selector(statusViewWillAppear) withObject:nil];
  }
  
  if ( translationDirection == UpToDown ) {
    
    [self showOnTopOfView:addToView];
		
	}else if ( translationDirection == DownToUp ) {
    
    [self showOnBottomOfView:addToView];
		
	}
  
  if ([delegate respondsToSelector:@selector(statusViewDidAppear)]) {
    [delegate performSelector:@selector(statusViewDidAppear) withObject:nil];
  }
  
}

/*
 Anime la disparition de la vue.
 @author : Rémi Lavedrine
 @date : 01/06/2011
 @remarks : (facultatif)
 */
- (void)animateRemove{
  
  if ([delegate respondsToSelector:@selector(statusViewWillDisappear)]) {
    [delegate performSelector:@selector(statusViewWillDisappear) withObject:nil];
  }
  
  
  float delay = STATUS_VIEW_ACTION_DELAY;
  
  
	if ( translationDirection == UpToDown ) {
		
		[self translateView:self toX:0 Y:-self.frame.size.height during:delay];
		
	}else if ( translationDirection == DownToUp ) {
		
		[self translateView:self toX:0 Y:self.frame.size.height during:delay];
		
	}
	
	
	[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:delay];
  
  
  if ([delegate respondsToSelector:@selector(statusViewDidDisappear)]) {
    [delegate performSelector:@selector(statusViewDidDisappear) withObject:nil afterDelay:delay];
  }
}

- (void)remove{
  
  if ([delegate respondsToSelector:@selector(statusViewWillDisappear)]) {
    [delegate performSelector:@selector(statusViewWillDisappear) withObject:nil];
  }
  
	[self removeFromSuperview];
  
  if ([delegate respondsToSelector:@selector(statusViewDidDisappear)]) {
    [delegate performSelector:@selector(statusViewDidDisappear) withObject:nil];
  }
  
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */


#pragma mark -
#pragma mark Color management

- (void)setViewBackgroundColor:(UIColor *)a_color{
	viewBackgroundColor = a_color;
	[self setBackgroundColor:viewBackgroundColor];
}

- (void)setStatusTextColor:(UIColor *)a_color{
	statusTextColor = a_color;
	[statusLabel setTextColor:statusTextColor];
}

- (void)setLineBackgroundColor:(UIColor *)a_color{
	lineBackgroundColor = a_color;
	[line setBackgroundColor:lineBackgroundColor];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[statusLabel release];
	[line release];
	[icon release];
	
	[viewBackgroundColor release];
	[statusTextColor release];
	[lineBackgroundColor release];
	
	
	[super dealloc];
}


@end












