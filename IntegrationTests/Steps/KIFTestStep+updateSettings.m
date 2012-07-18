//
//  KIFTestStep+updateSettings.m
//  Coderwall
//
//  Created by modocache on 6/30/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestStep+updateSettings.h"

#import "UIAccessibilityElement-KIFAdditions.h"


@interface KIFTestStep (InternalAPI)
+ (UIAccessibilityElement *)_accessibilityElementWithLabel:(NSString *)label
                                        accessibilityValue:(NSString *)value
                                                  tappable:(BOOL)mustBeTappable
                                                    traits:(UIAccessibilityTraits)traits
                                                     error:(out NSError **)error;
@end


@implementation KIFTestStep (updateSettings)


#pragma mark - Public Interface

+ (NSArray *)stepsToUpdateUsername:(NSString *)username
{
    NSMutableArray *steps = [NSMutableArray array];
    __block NSString *newUsername = username;

    [steps addObject:[KIFTestStep stepToClearUsernameTextField]];
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

+ (id)stepToClearUsernameTextField
{
    return [KIFTestStep stepWithDescription:@"Clear username"
                             executionBlock:
            ^KIFTestStepResult(KIFTestStep *step, NSError *__autoreleasing *error) {
                NSString *usernameTextFieldLabel = @"Username";

                // Clear previous text
                UIAccessibilityElement *element =
                    [self _accessibilityElementWithLabel:usernameTextFieldLabel
                                      accessibilityValue:nil
                                                tappable:YES
                                                  traits:UIAccessibilityTraitNone
                                                   error:error];

                if (!element) {
                    return KIFTestStepResultFailure;
                }

                UITextField *textField =
                    (UITextField *)[UIAccessibilityElement viewContainingAccessibilityElement:element];

                textField.text = @"";

                return KIFTestStepResultSuccess;
            }];
}

@end
