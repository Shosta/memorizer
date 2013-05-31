//
//  AlignScrollViewController.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 31/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "AlignScrollViewController.h"

@interface AlignScrollViewController ()

@end

@implementation AlignScrollViewController

#pragma mark - Align

- (void)align
{
  if (!self.tableView.visibleCells.count) return;
  
  UITableViewCell *cell = [[self.tableView visibleCells] objectAtIndex:0];
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  
  // si coupé + que moitié, alignement au cell suivant et inversement
  
  CGFloat cellOriginY   = cell.frame.origin.y;
  CGFloat contentOffset = self.tableView.contentOffset.y;
  CGFloat rowHeight = [self tableView:nil heightForRowAtIndexPath:indexPath];
  
  CGFloat cutTop = contentOffset-cellOriginY;
  BOOL next = (cutTop >= rowHeight/2.0f);
  
  UITableViewCell *newCell = [[self.tableView visibleCells] objectAtIndex:(next)?1:0];
  NSIndexPath *newIndexPath = [self.tableView indexPathForCell:newCell];
  
  [self.tableView scrollToRowAtIndexPath:newIndexPath
                        atScrollPosition:UITableViewScrollPositionTop
                                animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
  OLLogDebug(@"");
  [self align];
}


@end
