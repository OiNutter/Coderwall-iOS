//
//  SpecialityCell.m
//  Coderwall
//
//  Created by Will on 22/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "SpecialityCell.h"

@implementation SpecialityCell

@synthesize speciality;

-(void) setYPos:(CGFloat) yPos
{
    speciality.frame = CGRectMake(speciality.frame.origin.x, yPos, speciality.frame.size.width, speciality.frame.size.height);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
