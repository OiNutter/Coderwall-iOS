//
//  KIFTestStep+updateSettings.h
//  Coderwall
//
//  Created by modocache on 6/30/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestStep.h"


@interface KIFTestStep (updateSettings)

+ (NSArray *)stepsToUpdateUsername:(NSString *)username;
+ (id)stepToClearUserDefaults;

@end
