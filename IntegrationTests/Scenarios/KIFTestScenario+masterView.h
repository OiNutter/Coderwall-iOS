//
//  KIFTestScenario+masterView.h
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario.h"


@interface KIFTestScenario (masterView)

+ (id)scenarioToDisplayMasterViewWithoutSettingUser;
+ (id)scenarioToDisplayBadgesView;
+ (id)scenarioToDisplayAccomplishmentsView;
+ (id)scenarioToDisplayStatsView;
+ (id)scenarioToDisplaySearchView;

@end
