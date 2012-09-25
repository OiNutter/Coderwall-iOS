//
//  SearchViewController.m
//  Coderwall
//
//  Created by Will on 25/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "SearchViewController.h"
#import "User.h"
#import "UIViewController+appDelegateUser.h"
#import "MasterViewController.h"


@interface SearchViewController () <UISearchBarDelegate>

- (void)loadResultsView;

@end


@implementation SearchViewController


#pragma mark - UIViewController Overrides

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}


#pragma mark - UISearchBarDelegate Protocol Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(searchBar.text.length > 0){
        User *user = [[User alloc] initWithUsername:searchBar.text];
        [self setCurrentUser:user];
        [searchBar resignFirstResponder];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadResultsView)
                                                     name:@"UserChanged"
                                                   object:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You must enter a username!"
														message:nil
													   delegate:nil
                                              cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


#pragma mark - Internal Methods

- (void)loadResultsView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UserChanged" object:nil];
    [(MasterViewController *)self.parentViewController showSearchResults];
}

@end
