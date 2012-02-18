//
//  RoundedTableView.m
//  Coderwall
//
//  Created by Will on 11/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoundedTableView.h"
#import "QuartzCore/QuartzCore.h"

@implementation RoundedTableView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    self.layer.masksToBounds = NO;
    self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 2.5;
    self.layer.shadowOpacity = 0.5;
}

@end
