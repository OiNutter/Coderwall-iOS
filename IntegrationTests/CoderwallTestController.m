//
//  CoderwallTestController.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "CoderwallTestController.h"

#import "KIFTestScenario+masterView.h"
#import "KIFTestScenario+settingsView.h"


@interface CoderwallTestController ()

@end


@implementation CoderwallTestController

- (void)initializeScenarios
{
    // Master View
    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];

    [self addScenario:[KIFTestScenario scenarioToDisplayBadgesView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayAccomplishmentsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayStatsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplaySearchView]];

    // Settings View
    [self addScenario:[KIFTestScenario scenarioToDisplaySettingsView]];
    [self addScenario:[KIFTestScenario scenarioToSetSettingsUsername]];
    [self addScenario:[KIFTestScenario scenarioToSetInvalidSettingsUsername]];
    [self addScenario:[KIFTestScenario scenarioToSetNonexistentSettingsUsername]];

    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];

    // Reset application state.
    [self addScenario:[KIFTestScenario scenarioToClearUserDefaults]];
}

@end