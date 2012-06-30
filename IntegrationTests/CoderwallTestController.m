//
//  CoderwallTestController.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "CoderwallTestController.h"
#import "KIFTestScenario+masterView.h"


@interface CoderwallTestController ()

@end


@implementation CoderwallTestController

- (void)initializeScenarios
{
    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];
    [self addScenario:[KIFTestScenario scenarioToDisplayBadgesView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayAccomplishmentsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayStatsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplaySearchView]];
    [self addScenario:[KIFTestScenario scenarioToDisplaySettingsView]];
}

@end