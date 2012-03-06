//
//  SearchViewController.m
//  Coderwall
//
//  Created by Will on 25/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "SearchViewController.h"
#import "User.h"
#import "AppDelegateProtocol.h"
#import "MasterViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (void) setCurrentUser:(User *) currentUser
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    [theDelegate setCurrentUser:currentUser];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(searchBar.text.length >0){
        User *user = [[User alloc] initWithUsername:searchBar.text];
        [self setCurrentUser:user];
        [searchBar resignFirstResponder];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadResultsView) name:@"UserChanged" object:nil];        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You must enter a username!"
														message:nil
													   delegate:nil
                                              cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
    }
}

- (void)loadResultsView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UserChanged" object:nil];
    [(MasterViewController *)self.parentViewController showSearchResults];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
