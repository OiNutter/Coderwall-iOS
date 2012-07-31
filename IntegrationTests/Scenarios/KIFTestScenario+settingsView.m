//
//  KIFTestScenario+settingsView.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario+settingsView.h"

#import "KIFTestStep.h"
#import "KIFTestStep+updateSettings.h"


@implementation KIFTestScenario (settingsView)


#pragma mark - Public Interface

+ (id)scenarioToClearUserDefaults
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"Reset user defaults."];
    
    [scenario addStep:[KIFTestStep stepToClearUserDefaults]];
    
    return scenario;
}

+ (id)scenarioToDisplaySettingsView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can segue to settings view from master view."];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Settings"]];
    
    return scenario;
}

+ (id)scenarioToSetSettingsUsername:(NSString *)username
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can update username value in settings view."];
    
    NSString *input = [NSString stringWithFormat:@"%@\n", username];
    [scenario addStepsFromArray:[KIFTestStep stepsToUpdateUsername:input]];
    
    // Update should be successful, which means no alert view is displayed.
    [scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"OK"]];
    // Back button should still be displayed.
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Back"]];
    
    return scenario;
}

+ (id)scenarioToSetInvalidSettingsUsername
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User cannot input blank username in settings view."];
    
    [scenario addStepsFromArray:[KIFTestStep stepsToUpdateUsername:@"\n"]];
    
    // Update should not be successful. Check for alert to be displayed.
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"OK"]];
    // Back button should still be displayed.
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Back"]];
    
    return scenario;
}

+ (id)scenarioToSetNonexistentSettingsUsername
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User should be alerted when the coderwall user they entered "
                                 @"doesn't exist."];
    
    [scenario addStepsFromArray:[KIFTestStep stepsToUpdateUsername:@"____doesn't_exist____\n"]];
    
    // Update should not be successful. Check for alert to be displayed.
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"OK"]];
    // Back button should still be displayed.
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Back"]];
    
    return scenario;
}

@end
