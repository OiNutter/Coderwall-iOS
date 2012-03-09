//
//  ProfileViewController.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegateProtocol.h"
#import "User.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [profileBg setImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"UserChanged" object:nil];
    User *user = [self currentUser];
    if(user != (id)[NSNull null] && user.userName != @"" && user.userName.length != 0){
        [fullName setText:[NSString stringWithFormat:user.name]];
        NSString *summaryDetails = [[NSString alloc] initWithString:@""];
        
        if(user.title != (id)[NSNull null])
            summaryDetails = [summaryDetails stringByAppendingString:user.title];
        
        if(summaryDetails.length != 0 && user.company != (id)[NSNull null] && user.company.length != 0)
            summaryDetails = [summaryDetails stringByAppendingString:@" at "];
        
        if(user.company != (id)[NSNull null])
            summaryDetails = [summaryDetails stringByAppendingString:user.company];
        
        if(summaryDetails.length != 0)
            summaryDetails = [summaryDetails stringByAppendingString:@"\n"];
        
        summaryDetails = [summaryDetails stringByAppendingString:user.location];       
        
        CGSize maximumSize = CGSizeMake(260, 80);
        UIFont *summaryFont = [UIFont fontWithName:@"Helvetica" size:14];
        CGSize summaryStringSize = [summaryDetails sizeWithFont:summaryFont 
                                              constrainedToSize:maximumSize 
                                                  lineBreakMode:summary.lineBreakMode];
        
        [summary setText:summaryDetails];
        [summary setFrame:CGRectMake(30, 265, 260, summaryStringSize.height)];
        dispatch_queue_t downloadQueue = dispatch_queue_create("avatar downloader", NULL);
        dispatch_async(downloadQueue,^{
            UIImage *userAvatar = [user getAvatar];
            dispatch_async(dispatch_get_main_queue(), ^{
                [avatar setImage:userAvatar];
            });
        });
        dispatch_release(downloadQueue);
    } else {
        [summary setText:@""];
        [fullName setText:@""];
        [avatar setImage:Nil];
    }
}

-(void)reloadView
{
    [self viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    else
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
