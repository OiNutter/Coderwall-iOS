//
//  KIFTestStep+textField.m
//  Coderwall
//
//  Created by modocache on 7/27/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "KIFTestStep+textField.h"

#import "UIAccessibilityElement-KIFAdditions.h"


@interface KIFTestStep (InternalAPI)
+ (UIAccessibilityElement *)_accessibilityElementWithLabel:(NSString *)label
                                        accessibilityValue:(NSString *)value
                                                  tappable:(BOOL)mustBeTappable
                                                    traits:(UIAccessibilityTraits)traits
                                                     error:(out NSError **)error;
@end


@implementation KIFTestStep (textField)

+ (id)stepToClearTextFieldWithLabel:(NSString *)label
{
    return [KIFTestStep stepWithDescription:@"Clear text field with label"
                             executionBlock:
            ^KIFTestStepResult(KIFTestStep *step, NSError *__autoreleasing *error) {
                UIAccessibilityElement *element =
                    [self _accessibilityElementWithLabel:label
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
