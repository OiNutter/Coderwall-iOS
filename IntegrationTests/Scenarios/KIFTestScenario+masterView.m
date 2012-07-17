//
//  KIFTestScenario+masterView.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario+masterView.h"

#import "AppDelegate.h"
#import "KIFTestController.h"
#import "KIFTestStep.h"
#import "KIFTestStep+displayMasterView.h"
#import "UIView-KIFAdditions.h"


@implementation KIFTestScenario (masterView)


#pragma mark - Public Interface

+ (id)scenarioToDisplayMasterViewWithoutSettingUser
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                    @"User can access master view."];
    [scenario addStep:[KIFTestStep stepToPopToMasterView]];
    return scenario;
}

+ (id)scenarioToDisplayBadgesView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can segue to badges view from master view."];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Badges"]];
    return scenario;
}

+ (id)scenarioToDisplayAccomplishmentsView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can segue to accomplishments view from master view."];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Accomplishments"]];
    return scenario;
}

+ (id)scenarioToDisplayStatsView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can segue to stats view from master view."];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Stats"]];
    return scenario;
}

+ (id)scenarioToDisplaySearchView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                 @"User can segue to search view from master view."];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Search"]];
    return scenario;
}

@end
