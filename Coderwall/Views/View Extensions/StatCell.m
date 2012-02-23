//
//  StatsViewCell.m
//  Coderwall
//
//  Created by Will on 22/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "StatCell.h"

@implementation StatCell

@synthesize title;
@synthesize number;

-(void) setYPos:(CGFloat)yPos
{
    title.frame = CGRectMake(title.frame.origin.x, yPos, title.frame.size.width, title.frame.size.height);
    number.frame = CGRectMake(number.frame.origin.x, yPos, number.frame.size.width, number.frame.size.height);
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
