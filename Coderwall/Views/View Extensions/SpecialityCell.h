//
//  SpecialityCell.h
//  Coderwall
//
//  Created by Will on 22/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialityCell : UITableViewCell
{
    IBOutlet UILabel *speciality;
}

@property UILabel *speciality;

-(void) setYPos:(CGFloat) yPos;

@end