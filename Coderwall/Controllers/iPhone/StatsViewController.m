//
//  StatsViewControllerViewController.m
//  Coderwall
//
//  Created by Will on 21/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "StatsViewController.h"
#import "UIViewController+appDelegateUser.h"
#import "User.h"
#import "StatCell.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_refreshHeaderView == nil) {
		
        if (![UIRefreshControl class])
        {
            EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
            view.delegate = self;
            view.backgroundColor = [UIColor clearColor];
            [self.tableView addSubview:view];
            _refreshHeaderView = view;
            
            [_refreshHeaderView refreshLastUpdatedDate];
        }
        
        else
        {
            _ios6RefreshHeaderView = [[UIRefreshControl alloc]init];
            [_ios6RefreshHeaderView addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
            self.refreshControl = _ios6RefreshHeaderView;
		}
	}

    [self loadData];
}

-(void)refreshTable:(UIRefreshControl *)refresh
{
    _reloading = YES;
	User *user = [self currentUser];
    [user refresh];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
}

- (void)loadData
{

    User *user = [self currentUser];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *stats;
    
    if(user.stats != (id)[NSNull null] && user.stats.count > 0)
        stats = [[NSMutableArray alloc] initWithArray:user.stats];
    else
        stats = [[NSMutableArray alloc] init];
    
    // Create endorsements dictionary
    NSArray *labels = [[NSArray alloc] initWithObjects:@"description", @"number",nil];
    NSArray *values = [[NSArray alloc] initWithObjects:@"Endorsements", (user.endorsements != nil) ? user.endorsements: [NSNumber numberWithInt:0], nil];
    NSDictionary *endorsements = [[NSDictionary alloc] initWithObjects:values forKeys:labels];
    [stats addObject:endorsements];
    [data addObject:stats];
    [keys addObject:@"Statistics"];
        
    if(user.specialities != nil && user.specialities != (id)[NSNull null]){
        [data addObject:user.specialities];
        [keys addObject:@"Specialities"];
    }
        
    statsData = [[NSArray alloc] initWithArray:data];
    sections = [[NSArray alloc] initWithArray:keys];
    
}

- (void)reloadTable
{
    [self loadData];
    [self.tableView reloadData];
    _reloading = NO;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[self.statsData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    StatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statCell"];
    NSInteger numRows = [self tableView:self.tableView numberOfRowsInSection:indexPath.section];
    if((NSString *)[sections objectAtIndex:indexPath.section] == @"Specialities"){
        NSString *item = (NSString *)[(NSArray *)[statsData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.title.text = item;
        cell.number.text = @"";
    } else {
        NSArray *section = (NSArray *)[statsData objectAtIndex:indexPath.section];
        NSDictionary *item = (NSDictionary *)[section objectAtIndex:indexPath.row];
        cell.title.text = [item objectForKey:@"description"];
        cell.number.text = [(NSNumber *)[item objectForKey:@"number"] stringValue];
    }
    
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
    cell.backgroundView = background;
    
    if(indexPath.row ==0)
        [cell setYPos:21];
    else
        [cell setYPos:11];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [sections objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    
    if(indexPath.row == 0)
        height += 10;
    
    if(indexPath.row == [self tableView:self.tableView numberOfRowsInSection:indexPath.section]-1)
        height+=10; 
    
    return height;
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
    if (_refreshHeaderView != nil)
    {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    else
    {
        [_ios6RefreshHeaderView endRefreshing];
    }
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    if (_ios6RefreshHeaderView != nil)
    {
        [_ios6RefreshHeaderView beginRefreshing];
        [self refreshTable:_ios6RefreshHeaderView];
    }
    else
    {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    _reloading = YES;
	User *user = [self currentUser];
    [user refresh];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    
}

- (BOOL) egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
	return _reloading; // should return if data source model is reloading
    
}

- (NSDate*) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
	return [NSDate date]; // should return date data source was last changed
    
}

@end
