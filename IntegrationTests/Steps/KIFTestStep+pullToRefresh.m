//
//  KIFTestStep+pullToRefresh.m
//  Coderwall
//
//  Created by modocache on 7/26/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestStep+pullToRefresh.h"


@implementation KIFTestStep (pullToRefresh)

+ (id)stepsToPullToRefresh
{
    NSMutableArray *steps = [NSMutableArray array];

    [steps addObject:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:nil
                                                            inDirection:KIFSwipeDirectionDown]];

    return steps;
}

@end
