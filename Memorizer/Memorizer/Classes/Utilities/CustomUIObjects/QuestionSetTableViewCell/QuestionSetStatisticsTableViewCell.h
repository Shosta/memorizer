//
//  QuestionSetStatisticsTableViewCell.h
//  Memorizer
//
//  Created by Rems on 23/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "QuestionSetTableViewCell.h"

@interface QuestionSetStatisticsTableViewCell : QuestionSetTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *level1CardSatistiscs;
@property (weak, nonatomic) IBOutlet UILabel *level2CardSatistiscs;
@property (weak, nonatomic) IBOutlet UILabel *level3CardSatistiscs;

@end
