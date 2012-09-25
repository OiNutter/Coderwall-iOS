//
//  ProfileViewController.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIViewController+appDelegateUser.h"
#import "User.h"
#import "DejalActivityView.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"UserChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetReloading) name:@"ConnectionError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetReloading) name:@"ResponseError" object:nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (_refreshHeaderView == nil) {
		
        /*
         EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
         view.delegate = self;
         view.backgroundColor = [UIColor clearColor];
         [self.tableView addSubview:view];
         _refreshHeaderView = view;
         */
        
        _refreshHeaderView = [[UIRefreshControl alloc]init];
        [_refreshHeaderView addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
        [profileScrollView addSubview:_refreshHeaderView];
		
	}
    
    if(summary.text == @"Summary") 
        [summary setText:@""];
    
    if(fullName.text == @"Full Name")
        [fullName setText:@""];
    
    [self loadData];
    
}

-(void)refreshTable:(UIRefreshControl *)sender
{
	User *user = [self currentUser];
    [user refresh];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
}

- (void)loadData
{
    
    [profileBg setImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
    User *user = [self currentUser];
    if(user != (id)[NSNull null] && user.userName != @"" && user.userName.length != 0){
        [fullName setText:user.name];
        NSString *summaryDetails = @"";
        
        if(user.title != (id)[NSNull null] && user.title != nil)
            summaryDetails = [summaryDetails stringByAppendingString:user.title];
        
        if(summaryDetails.length != 0 && user.company != (id)[NSNull null] && user.company != nil && user.company.length != 0)
            summaryDetails = [summaryDetails stringByAppendingString:@" at "];
        
        if(user.company != (id)[NSNull null] && user.company != nil)
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
        
        [avatar setImage:[UIImage imageNamed:@"defaultavatar.png"]];
        if(user.thumbnail != nil){
            [DejalBezelActivityView activityViewForView:avatar];
            dispatch_queue_t downloadQueue = dispatch_queue_create("avatar downloader", NULL);
            dispatch_async(downloadQueue,^{
                UIImage *userAvatar = [user getAvatar];
                [self performSelectorOnMainThread:@selector(setUserAvatar:) 
                                       withObject:userAvatar
                                    waitUntilDone:YES];
            });
            dispatch_release(downloadQueue);
        }
    } else {
        [summary setText:@""];
        [fullName setText:@""];
        [avatar setImage:[UIImage imageNamed:@"defaultavatar.png"]];
    }
    
    
}

- (void)setUserAvatar:(UIImage *)userAvatar
{
    if(userAvatar)
        [avatar setImage:userAvatar];
    else
        [avatar setImage:[UIImage imageNamed:@"defaultavatar.png"]];
    [DejalActivityView removeView];
}

-(void)reloadView
{
    _reloading = NO;
    [self loadData];
}

-(void)resetReloading
{
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    _reloading = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    else
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	[_refreshHeaderView endRefreshing];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView beginRefreshing];
    [self refreshTable:_refreshHeaderView];
}

@end
