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
#import "KIFTestScenario+searchView.h"
#import "KIFTestScenario+searchResultsView.h"


@interface CoderwallTestController ()
- (void)initializePhoneScenarios;
- (void)initializePadScenarios;
@end


@implementation CoderwallTestController


#pragma mark - KIFTestController Overrides

- (void)initializeScenarios
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self initializePadScenarios];
    } else {
        [self initializePhoneScenarios];
    }
}


#pragma mark - Internal Methods

- (void)initializePhoneScenarios
{
    // Master View
    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];
    
    [self addScenario:[KIFTestScenario scenarioToDisplayBadgesView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayAccomplishmentsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayStatsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplaySearchView]];
    
    // Settings View
    [self addScenario:[KIFTestScenario scenarioToDisplaySettingsView]];
    [self addScenario:[KIFTestScenario scenarioToSetInvalidSettingsUsername]];
    [self addScenario:[KIFTestScenario scenarioToSetNonexistentSettingsUsername]];
    [self addScenario:[KIFTestScenario scenarioToSetSettingsUsername:@"modocache"]];

    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];

    // Search
    [self addScenario:[KIFTestScenario scenarioToDisplaySearchView]];
    [self addScenario:[KIFTestScenario scenarioToSearchForUsername:@"OiNutter"]];
    [self addScenario:[KIFTestScenario scenarioToDisplayBadgesView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayAccomplishmentsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayStatsView]];

    [self addScenario:[KIFTestScenario scenarioToPopToSearchView]];
    [self addScenario:[KIFTestScenario scenarioToSearchForInvalidUsername]];
    
    // Reset application state.
    [self addScenario:[KIFTestScenario scenarioToClearUserDefaults]];
}

- (void)initializePadScenarios
{
    // Master View
    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];
    
    [self addScenario:[KIFTestScenario scenarioToDisplayBadgesView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayAccomplishmentsView]];
    [self addScenario:[KIFTestScenario scenarioToDisplaySearchView]];
    
    // Settings View
    [self addScenario:[KIFTestScenario scenarioToDisplaySettingsView]];
    // Cannot dismiss UIAlertView in landscape orientation
    // https://github.com/square/KIF/issues/60
    // [self addScenario:[KIFTestScenario scenarioToSetInvalidSettingsUsername]];
    // [self addScenario:[KIFTestScenario scenarioToSetNonexistentSettingsUsername]];
    [self addScenario:[KIFTestScenario scenarioToSetSettingsUsername:@"modocache"]];

    [self addScenario:[KIFTestScenario scenarioToDisplayMasterViewWithoutSettingUser]];

    // Search
    [self addScenario:[KIFTestScenario scenarioToDisplaySearchView]];
    [self addScenario:[KIFTestScenario scenarioToSearchForUsername:@"OiNutter"]];
    [self addScenario:[KIFTestScenario scenarioToDisplayBadgesView]];
    [self addScenario:[KIFTestScenario scenarioToDisplayAccomplishmentsView]];

    [self addScenario:[KIFTestScenario scenarioToPopToSearchView]];
    // Cannot dismiss UIAlertView in landscape orientation
    // https://github.com/square/KIF/issues/60
    // [self addScenario:[KIFTestScenario scenarioToSearchForInvalidUsername]];
    
    // Reset application state.
    [self addScenario:[KIFTestScenario scenarioToClearUserDefaults]];
}

@end