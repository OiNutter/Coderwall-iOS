//
//  KIFTestScenario+displayMasterView.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//

#import "KIFTestScenario+displayMasterView.h"
#import "KIFTestStep.h"

@implementation KIFTestScenario (displayMasterView)

+ (id)scenarioToDisplayMasterView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:
                                    @"User can access master view."];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Back"]];
    
    return scenario;
}

@end
