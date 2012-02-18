//
//  ShadowView.m
//  Coderwall
//
//  Created by Will on 11/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ShadowView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@implementation ShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 2.5;
    self.layer.shadowOpacity = 0.5;
    self.layer.cornerRadius = 5;
    self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.layer.cornerRadius = 5;
}


@end
