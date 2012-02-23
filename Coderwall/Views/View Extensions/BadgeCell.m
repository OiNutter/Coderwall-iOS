//
//  BadgeViewCell.m
//  Coderwall
//
//  Created by Will on 19/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "BadgeCell.h"
#import "QuartzCore/QuartzCore.h"

@implementation BadgeCell

@synthesize badge;
@synthesize detail;
@synthesize title;

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
