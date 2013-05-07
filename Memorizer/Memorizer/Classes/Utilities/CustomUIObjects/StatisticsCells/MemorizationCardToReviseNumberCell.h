//
//  MemorizationCardToReviseNumberCell.h
//  Memorizer
//
//  Created by Rems on 03/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemorizationCardToReviseNumberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardNumberTodayLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberTomorrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberInTwoDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberInThreeDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberInFourDaysLabel;

@end
