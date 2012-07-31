//
//  KIFTestScenario+searchResultsView.m
//  Coderwall
//
//  Created by modocache on 7/26/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario+searchResultsView.h"

#import "KIFTestStep.h"
#import "KIFTestStep+textField.h"


@implementation KIFTestScenario (searchResultsView)

+ (id)scenarioToPopToSearchView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can go back to search view from results view."];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Back"]];
    [scenario addStep:[KIFTestStep stepToClearTextFieldWithLabel:@"Search for username"]];
    
    return scenario;
}

@end
