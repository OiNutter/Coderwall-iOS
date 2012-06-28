//
//  CoderwallTestController.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//

#import "CoderwallTestController.h"
#import "KIFTestScenario+displayMasterView.h"

@interface CoderwallTestController ()

@end


@implementation CoderwallTestController

- (void)initializeScenarios
{
    [self addScenario:[KIFTestScenario scenarioToDisplayMasterView]];
}

@end