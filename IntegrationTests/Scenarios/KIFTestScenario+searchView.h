//
//  KIFTestScenario+searchView.h
//  Coderwall
//
//  Created by modocache on 7/26/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestScenario.h"


@interface KIFTestScenario (searchView)

+ (id)scenarioToSearchForUsername:(NSString *)username;
+ (id)scenarioToSearchForInvalidUsername;

@end
