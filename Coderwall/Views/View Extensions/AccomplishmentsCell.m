//
//  AccomplishmentsViewCell.m
//  Coderwall
//
//  Created by Will on 20/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "AccomplishmentCell.h"

@implementation AccomplishmentCell

@synthesize detail;

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
