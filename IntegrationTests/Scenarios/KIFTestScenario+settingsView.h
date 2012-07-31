//
//  KIFTestScenario+settingsView.h
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario.h"


@interface KIFTestScenario (settingsView)

+ (id)scenarioToClearUserDefaults;
+ (id)scenarioToDisplaySettingsView;
+ (id)scenarioToSetSettingsUsername:(NSString *)username;
+ (id)scenarioToSetInvalidSettingsUsername;
+ (id)scenarioToSetNonexistentSettingsUsername;

@end
