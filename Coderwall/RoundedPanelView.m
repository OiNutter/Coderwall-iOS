//
//  RoundedPanelView.m
//  Coderwall
//
//  Created by Will on 11/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoundedPanelView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@implementation RoundedPanelView

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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;

}


@end
