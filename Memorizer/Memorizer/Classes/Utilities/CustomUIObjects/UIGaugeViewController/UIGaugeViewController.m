//
//  UIGaugeViewController.m
//  MobinilAndMe
//
//  Created by Rémi LAVEDRINE on 06/11/12.
//  Copyright (c) 2012 France Telecom. All rights reserved.
//

#import "UIGaugeViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIGaugeViewController
@synthesize progress = progress_;
@synthesize leftText = leftText_;
@synthesize rightText = rightText_;
@synthesize progressView;
@synthesize leftTextLabel;
@synthesize rightTextLabel;


#pragma mark - Object

#define VIEW_WIDTH 260
#define PROGRESSVIEW_ORIGIN_X 2
#define PROGRESSVIEW_HEIGHT 10

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.progress = 1.0;
    self.progressView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar_progress_top.png"]];
    [self.progressView setFrame:CGRectMake(PROGRESSVIEW_ORIGIN_X, 1, VIEW_WIDTH - PROGRESSVIEW_ORIGIN_X, PROGRESSVIEW_HEIGHT)];
    self.leftTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, VIEW_WIDTH/2, 19)];
    self.rightTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2, 10, VIEW_WIDTH/2, 19)];
  }
  
  return self;
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View

- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self animateProgressBar];
  [self.leftTextLabel setText:self.leftText];
  [self.rightTextLabel setText:self.rightText];
}

- (void)viewDidUnload
{
  [self setLeftText:nil];
  [self setRightText:nil];
  
  [self setProgressView:nil];
  [self setLeftTextLabel:nil];
  [self setRightTextLabel:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Custom Getters & Setters

- (void)animateProgressBarDuring:(float)duration{
  @try {
    if (self.progress == 0.0){
      self.progress = self.progress + 0.0001;
    }
    float w = VIEW_WIDTH - PROGRESSVIEW_ORIGIN_X;
    float h = 2 + PROGRESSVIEW_HEIGHT; // We add 2 because of the progress bar icon under the ProgressView which has 1px more on each side for white effect when highlighted.
    float newWidth = (float)w* (float)self.progress;
    float xNewCenter = (w - newWidth) + newWidth/2 + PROGRESSVIEW_ORIGIN_X;
    float yNewCenter = h/2;
    
    float relativeDuration = duration * (1.0 - self.progress);
    [UIView animateWithDuration:relativeDuration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:(void (^)(void)) ^{
                       
                       // OLLogDebug(@"Progress : %f; FrameWidth : %f; NewWidth : %f; x : %f; y : %f", self.progress, w, newWidth, xNewCenter, yNewCenter);
                       
                       self.progressView.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.progress, 1.0);
                       self.progressView.center = CGPointMake(xNewCenter, yNewCenter);
                     }
                     completion:^(BOOL finished){
                       
                     }];
    
  }
  @catch (NSException *exception) {
    OLLogDebug(@"%@", exception.reason);
  }
  @finally {
    
  }
}

- (void)animateProgressBar{
  [self animateProgressBarDuring:1.0];
}

- (void)setProgress:(float)aProgress{
  progress_ = aProgress;
  [self animateProgressBar];
}

- (void)setLeftText:(NSString *)aLeftText{
  leftText_ = aLeftText;
  [self.leftTextLabel setText:aLeftText];
}

- (void)setRightText:(NSString *)aRightText{
  rightText_ = aRightText;
  [self.rightTextLabel setText:aRightText];
}


@end
