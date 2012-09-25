//
//  KIFTestScenario+searchView.m
//  Coderwall
//
//  Created by modocache on 7/26/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario+searchView.h"

#import "KIFTestStep.h"


@implementation KIFTestScenario (searchView)


#pragma mark - Public Interface

+ (id)scenarioToSearchForUsername:(NSString *)username
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can search for username."];
    
    NSString *text = [NSString stringWithFormat:@"%@\n", username];
    [scenario addStep:[KIFTestStep stepToEnterText:text
                    intoViewWithAccessibilityLabel:@"Search for username"]];
    [scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Full Name"]];
    
    return scenario;
}

+ (id)scenarioToSearchForInvalidUsername
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User is informed of error when attempting search for "
                                 @"invalid username."];
    
    [scenario addStep:[KIFTestStep stepToEnterText:@"____doesn't_exist____\n"
                    intoViewWithAccessibilityLabel:@"Search for username"]];
    // Alert is displayed
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"OK"]];
    
    return scenario;
}

@end
