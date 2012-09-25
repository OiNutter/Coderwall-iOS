//
//  SummaryViewController.m
//  Coderwall
//
//  Created by Will on 03/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "SummaryViewController.h"
#import "ProfileCell.h"
#import "StatCell.h"
#import "User.h"
#import "UIViewController+appDelegateUser.h"
#import "DejalActivityView.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController

@synthesize statsData;
@synthesize sections;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"UserChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetReloading) name:@"ConnectionError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetReloading) name:@"ResponseError" object:nil];
    return self;
}

- (void)loadData
{
    [super viewDidLoad];
    
    User *user = [self currentUser];
    
    if(user != (id)[NSNull null] && user.userName != @"" && user.userName.length != 0){
        NSMutableArray *data = [[NSMutableArray alloc] init];
        NSMutableArray *keys = [[NSMutableArray alloc] init];
        NSMutableArray *stats;
    
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
        
        NSArray *profileData = [[NSArray alloc] init];
        NSArray *profileKeys = [[NSArray alloc] init];
        
        if(user.thumbnail != nil){
            profileData = [[NSArray alloc] initWithObjects:user.name,summaryDetails,user.thumbnail,nil];
            profileKeys = [[NSArray alloc] initWithObjects:@"fullName",@"summary",@"avatar", nil];
        } else {
            profileData = [[NSArray alloc] initWithObjects:user.name,summaryDetails,nil];
            profileKeys = [[NSArray alloc] initWithObjects:@"fullName",@"summary", nil];
        }
        NSDictionary *userProfile = [[NSDictionary alloc] initWithObjects:profileData forKeys: profileKeys];
    
        [data addObject:[[NSArray alloc] initWithObjects:userProfile,nil]];
        [keys addObject:@"Profile"];
    
        if(user.stats != (id)[NSNull null] && user.stats.count > 0)
            stats = [[NSMutableArray alloc] initWithArray:user.stats];
        else
            stats = [[NSMutableArray alloc] init];
    
        // Create endorsements dictionary
        NSArray *labels = [[NSArray alloc] initWithObjects:@"description", @"number",nil];
        NSArray *values = [[NSArray alloc] initWithObjects:@"Endorsements", user.endorsements, nil];
        NSDictionary *endorsements = [[NSDictionary alloc] initWithObjects:values forKeys:labels];
        [stats addObject:endorsements];
        [data addObject:stats];
        [keys addObject:@"Statistics"];
    
        if(user.specialities != (id)[NSNull null] && user.specialities != nil){
            [data addObject:user.specialities];
            [keys addObject:@"Specialities"];
        }
    
        statsData = [[NSArray alloc] initWithArray:data];
        sections = [[NSArray alloc] initWithArray:keys];
    
        if([NSStringFromClass([self.parentViewController class]) isEqualToString:@"MasterViewController"]){
            UIButton* fakeButton = (UIButton *) [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inset-logo.png"]];
            UIBarButtonItem *fakeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fakeButton];
            self.parentViewController.navigationItem.leftBarButtonItem = fakeButtonItem;
            self.parentViewController.navigationItem.title = [[NSString alloc] initWithString:user.userName];
        }
    }
    
    [self.tableView setBackgroundView:nil];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
        view.backgroundColor = [UIColor clearColor];
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)reloadTable
{
    [self loadData];
    [self.tableView reloadData];
    _reloading = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

-(void)resetReloading
{
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    _reloading = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.frame = CGRectMake(-10, 0, 330, self.tableView.frame.size.height);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[self.statsData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger numRows = [self tableView:self.tableView numberOfRowsInSection:indexPath.section];
    
    UIImageView *background;
    if(indexPath.row==0 && numRows==1)
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
    else if(indexPath.row == 0)
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 1, 0)]];
    else if(indexPath.row == numRows-1)
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 15, 0)]];
    else
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableMiddleBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 0)]];

    [background setContentMode:UIViewAutoresizingFlexibleHeight];
    [background setClipsToBounds:true];
    
    if((NSString *)[sections objectAtIndex:indexPath.section] == @"Profile"){
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
        NSArray *section = (NSArray *)[statsData objectAtIndex:indexPath.section];
        NSDictionary *item = (NSDictionary *)[section objectAtIndex:indexPath.row];
        cell.title.text = [item objectForKey:@"fullName"];
        cell.detail.text = [item objectForKey:@"summary"];
        [cell.avatar setImage:[UIImage imageNamed:@"defaultavatar.png"]];
        if([item objectForKey:@"avatar"]){
            [DejalBezelActivityView activityViewForView:cell.avatar];
            dispatch_queue_t downloadQueue = dispatch_queue_create("download queue", NULL);
            dispatch_async(downloadQueue, ^{
                User *user = [self currentUser];
                UIImage *userAvatar = [user getAvatar];
                NSArray * objs = [NSArray arrayWithObjects:cell.avatar,userAvatar, nil];
                [self performSelectorOnMainThread:@selector(setUserAvatar:) 
                                       withObject:objs
                                    waitUntilDone:YES];
            });
        }
        cell.backgroundView = background;
        return cell;
    } else if((NSString *)[sections objectAtIndex:indexPath.section] == @"Specialities"){
        StatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statCell"];
        NSString *item = (NSString *)[(NSArray *)[statsData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.title.text = item;
        cell.number.text = @"";
        
        cell.backgroundView = background;
        
        if(indexPath.row ==0)
            [(StatCell *)cell setYPos:21];
        else
            [(StatCell *)cell setYPos:11];        
        
        return cell;
        
    } else {
        StatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statCell"];
        NSArray *section = (NSArray *)[statsData objectAtIndex:indexPath.section];
        NSDictionary *item = (NSDictionary *)[section objectAtIndex:indexPath.row];
        cell.title.text = [item objectForKey:@"description"];
        cell.number.text = [(NSNumber *)[item objectForKey:@"number"] stringValue];
        
        cell.backgroundView = background;
        
        if(indexPath.row ==0)
            [(StatCell *)cell setYPos:21];
        else
            [(StatCell *)cell setYPos:11];        
        
        return cell;
    }
    
    

}

- (void)setUserAvatar:(NSArray *)objs
{
    if([objs count]>1)
        [[objs objectAtIndex:0] setImage:[objs objectAtIndex:1]];
    else 
        [[objs objectAtIndex:0] setImage:[UIImage imageNamed:@"defaultavatar.png"]];
    [DejalActivityView removeView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [sections objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((NSString *)[sections objectAtIndex:indexPath.section] == @"Profile"){
        return 325;
    } else {
        
        CGFloat height = 44;
    
        if(indexPath.row == 0)
            height += 10;
    
        if(indexPath.row == [self tableView:self.tableView numberOfRowsInSection:indexPath.section]-1)
            height+=10; 
    
        return height;
        
    }
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    _reloading = YES;
	User *user = [self currentUser];
    [user refresh];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
