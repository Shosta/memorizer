//
//  MemorizationCardLevelNumberCell.h
//  Memorizer
//
//  Created by Rems on 03/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemorizationCardLevelNumberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardTotalCount;

@property (weak, nonatomic) IBOutlet UILabel *level1CardSatistiscs;
@property (weak, nonatomic) IBOutlet UILabel *level2CardSatistiscs;
@property (weak, nonatomic) IBOutlet UILabel *level3CardSatistiscs;
@property (weak, nonatomic) IBOutlet UILabel *level4CardSatistiscs;
@property (weak, nonatomic) IBOutlet UILabel *level5CardSatistiscs;

@end
