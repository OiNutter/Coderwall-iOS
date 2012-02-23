//
//  StatsViewCell.h
//  Coderwall
//
//  Created by Will on 22/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatCell : UITableViewCell
{
    IBOutlet UILabel *title;
    IBOutlet UILabel *number;
}

@property UILabel *title;
@property UILabel *number;

-(void) setYPos:(CGFloat) yPos;

@end
