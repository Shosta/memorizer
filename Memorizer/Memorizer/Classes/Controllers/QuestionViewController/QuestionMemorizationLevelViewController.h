//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : QuestionMemorizationLevelViewController.h
// Created     : $ 11/04/13 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2013, All Rights Reserved
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
// This ViewController displays a Question and handle all the user interactions to display the answer, the description and the buttons in order to store the user's memorization level.
// It handles as well the interaction to pass to the next question only when the user displays the answer.
// 

#import "QuestionViewController.h"

@interface QuestionMemorizationLevelViewController : QuestionViewController

@property (weak, nonatomic) IBOutlet UIButton *level1Button;
@property (weak, nonatomic) IBOutlet UIButton *level2Button;
@property (weak, nonatomic) IBOutlet UIButton *level3Button;
@property (weak, nonatomic) IBOutlet UIButton *level4Button;
@property (weak, nonatomic) IBOutlet UIButton *level5Button;

@property (weak, nonatomic) NSNumber *isMemorizationLevelChosen;
@property  MemorizationLevel memorizationLevel;


@end
