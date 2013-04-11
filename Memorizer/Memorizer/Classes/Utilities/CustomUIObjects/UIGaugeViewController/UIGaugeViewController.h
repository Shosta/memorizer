//--------------------------------------------------------
// FT/OLNC/OLPS/SOFT/IDF-NANCY/MSF
//--------------------------------------------------------
// Project     : Memorizer
// File        : UIGaugeViewController.h
// Created     : $ 06/11/12 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright France Telecom 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of France Telecom.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// France Telecom.
//--------------------------------------------------------
// 
// @brief
// Create and handle the animation of a gauge inside a view.
// It is used in "BalanceTableViewController" and "DetailedBalanceTableViewController" in order to display the gauge.
//
// Describes a UITableViewCell which labels are organized in the following way.
// ------------------------------------------------------------------------------
// |----------------------------------------------------------------------------|
// ||                                                                          ||
// || The gauge background view and the gauge progress image view on top of it ||
// ||                                                                          ||
// |----------------------------------------------------------------------------|
// |----------------------------------------------------------------------------|
// || The left gauge TextLabel                       The right gauge TextLabel ||
// |----------------------------------------------------------------------------|
// ------------------------------------------------------------------------------
//

#import <UIKit/UIKit.h>


//! @brief Create and handle the animation of a gauge inside a view.
//! @class UIGaugeViewController
//! @ingroup CustomUIObjects
//! @author Rémi Lavedrine
@interface UIGaugeViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *progressView;
@property (retain, nonatomic) IBOutlet UILabel *leftTextLabel;
@property (retain, nonatomic) IBOutlet UILabel *rightTextLabel;

@property (nonatomic) float progress;
@property (retain, nonatomic) NSString *leftText;
@property (retain, nonatomic) NSString *rightText;


//! Animate the progress Bar according to the current progress value.
- (void)animateProgressBar;

@end
