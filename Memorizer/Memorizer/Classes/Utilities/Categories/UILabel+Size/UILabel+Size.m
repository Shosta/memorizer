//
//  UILabel+Size.m
//  MobinilAndMe
//
//  Created by Rémi LAVEDRINE on 04/05/12.
//  Copyright (c) 2012 France Telecom. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)

/**
 @brief Adjusts Adjusts UILabel's frame to begin at defined x and y position and have a dynamic height 
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^) 
 @remarks : <#(optional)#>
 */
-(void)setUpMultiLineFrameWithStartXPosition:(CGFloat)startX withStartYPosition:(CGFloat)startY
{
	self.lineBreakMode = NSLineBreakByWordWrapping;
	self.numberOfLines = 0;//instructs the label to contain any number of lines
	
	CGSize minSize = [self getSize];
	[self setFrame:CGRectMake(startX, startY, minSize.width, minSize.height)];
}

/**
 @brief Adjusts UILabel's frame to begin at defined x position, to maxiumum width and height, centered veritcally based on maxHeight and height of content 
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^) 
 @remarks : <#(optional)#>
 */
-(void)setUpMultiLineFrameBasedOnWidth:(CGFloat)maxWidth withStartXPosition:(CGFloat)startX withHeight:(CGFloat)maxHeight{
	self.lineBreakMode = NSLineBreakByWordWrapping;
	self.numberOfLines = 0; //instructs the label to contain any number of lines
	
	CGFloat labelHeight = [self getHeightBasedOnWidth:maxWidth];
	CGFloat padding = ((maxHeight - labelHeight)/2); //center label within maxHeight box
	[self setFrame:CGRectMake(startX, padding, maxWidth, labelHeight)];
}

/**
 @brief Adjusts UILabel's frame to begin at defined x and y position, to maxiumum width and have a dynamic height 
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^) 
 @remarks : <#(optional)#>
 */
-(void)setUpMultiLineFrameBasedOnWidth:(CGFloat)maxWidth withStartXPosition:(CGFloat)startX withStartYPosition:(CGFloat)startY{
	
	self.lineBreakMode = NSLineBreakByWordWrapping;
	self.numberOfLines = 0;//instructs the label to contain any number of lines
	
	CGFloat labelHeight = [self getHeightBasedOnWidth:maxWidth];
	[self setFrame:CGRectMake(startX, startY, maxWidth, labelHeight)];
}

/**
 @brief Adjusts UILabel's frame to begin at defined x position, to maximum width 
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^) 
 @remarks : <#(optional)#>
 */
-(void)setUpMultiLineFrameBasedOnWidth:(CGFloat)maxWidth withStartXPosition:(CGFloat)startX{
	self.lineBreakMode = NSLineBreakByWordWrapping;
	self.numberOfLines = 0;//instructs the label to contain any number of lines
	
	CGFloat labelHeight = [self getHeightBasedOnWidth:maxWidth];
	[self setFrame:CGRectMake(startX, 0, maxWidth, labelHeight)];
}

/**
 @brief Returns height value of UILabel based on content and max width 
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^) 
 @remarks : <#(optional)#>
 */
-(CGFloat)getHeightBasedOnWidth:(CGFloat)maxWidth{
	
	CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, 9999) lineBreakMode:self.lineBreakMode];
	
	return size.height;
}

/**
 @brief Returns size of UILabel based on content 
 @author : Rémi Lavedrine
 @date : 04/05/2012 (May the 4th be with you ^^) 
 @remarks : <#(optional)#>
 */
-(CGSize)getSize{
	CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(9999, 9999) lineBreakMode:self.lineBreakMode];
	
	return size;
}

@end
