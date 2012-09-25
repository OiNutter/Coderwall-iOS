//
//  KIFTestStep+updateSettings.m
//  Coderwall
//
//  Created by modocache on 6/30/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestStep+updateSettings.h"

#import "KIFTestStep+textField.h"


@implementation KIFTestStep (updateSettings)


#pragma mark - Public Interface

+ (NSArray *)stepsToUpdateUsername:(NSString *)username
{
    NSMutableArray *steps = [NSMutableArray array];
    __block NSString *newUsername = username;

    [steps addObject:[KIFTestStep stepToClearTextFieldWithLabel:@"Username"]];
    [steps addObject:[KIFTestStep stepToEnterText:newUsername
                   intoViewWithAccessibilityLabel:@"Username"]];

    return steps;
}

+ (id)stepToClearUserDefaults
{
    return [KIFTestStep stepWithDescription:@"Clear NSUserDefaults"
                             executionBlock:
            ^KIFTestStepResult(KIFTestStep *step, NSError *__autoreleasing *error) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"UserName"];
                [defaults synchronize];

                return KIFTestStepResultSuccess;
            }];
}

@end
