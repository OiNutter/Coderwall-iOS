//
//  UserSpec.m
//  Coderwall
//
//  Created by modocache on 27/06/2012.
//

#import "Kiwi.h"
#import "ILCannedURLProtocol.h"
#import "User.h"


SPEC_BEGIN(UserSpec)

describe(@"", ^{
    
    NSDictionary *testResponseHeaders = \
        [NSDictionary dictionaryWithObject:@"application/json; charset=utf-8" 
                                    forKey:@"Content-Type"];
    
    NSString *testResponseString = \
        @"{"
        @"    \"accounts\": {"
        @"        \"github\": \"coderwally\""
        @"    }, "
        @"    \"badges\": ["
        @"        {"
        @"            \"badge\": \"http://cdn.coderwall.com/assets/badges/forked1-ccde995368958c2e041acd64d8e4445f.png\", "
        @"            \"created\": \"2012-05-24T09:21:22Z\", "
        @"            \"description\": \"Have a project valued enough to be forked by someone else\", "
        @"            \"name\": \"Forked\""
        @"        }, "
        @"        {"
        @"            \"badge\": \"http://cdn.coderwall.com/assets/badges/altrustic-ac4b637a6c9fb3801257550f0a870acc.png\", "
        @"            \"created\": \"2012-05-17T11:56:47Z\", "
        @"            \"description\": \"Increase developer well-being by sharing at least 20 open source projects\", "
        @"            \"name\": \"Altruist\""
        @"        }"
        @"    ], "
        @"    \"endorsements\": 0, "
        @"    \"location\": \"Brooklyn, NY\", "
        @"    \"name\": \"Wally Coder\", "
        @"    \"team\": null, "
        @"    \"username\": \"coderwally\""
        @"}";
    
    NSData *testResponseData = [testResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    xit(@"should show a useful description", ^{});
    
    it(@"should download user info", ^{
        [NSURLProtocol registerClass:[ILCannedURLProtocol class]];
        [ILCannedURLProtocol setCannedStatusCode:200];
        [ILCannedURLProtocol setCannedHeaders:testResponseHeaders];
        [ILCannedURLProtocol setCannedResponseData:testResponseData];
        
        User *user = [User new];
        [[expectFutureValue(user.userName) shouldEventually] equal:@"coderwally"];
    });
});

SPEC_END