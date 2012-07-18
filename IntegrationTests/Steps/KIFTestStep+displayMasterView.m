//
//  KIFTestStep+displayMasterView.m
//  Coderwall
//
//  Created by modocache on 6/30/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestStep+displayMasterView.h"
#import "UIView-KIFAdditions.h"


@implementation KIFTestStep (displayMasterView)


#pragma mark - Public Interface

+ (id)stepToPopToMasterView
{
    return [KIFTestStep stepToTapViewWithAccessibilityLabel:@"Back"];
}

@end
