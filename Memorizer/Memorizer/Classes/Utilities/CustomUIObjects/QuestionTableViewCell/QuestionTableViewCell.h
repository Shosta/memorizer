//
//  QuestionTableViewCell.h
//  Memorizer
//
//  Created by Rems on 03/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *memorizationLevelImageView;
@property (weak, nonatomic) IBOutlet UILabel *statementLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
