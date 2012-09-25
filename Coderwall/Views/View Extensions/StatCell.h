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
    IBOutlet UILabel *__weak title;
    IBOutlet UILabel *__weak number;
}

@property (weak) UILabel *title;
@property (weak) UILabel *number;

-(void) setYPos:(CGFloat) yPos;

@end
