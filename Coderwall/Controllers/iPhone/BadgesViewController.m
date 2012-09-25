//
//  BadgesViewController.m
//  Coderwall
//
//  Created by Will on 19/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "BadgesViewController.h"
#import "User.h"
#import "UIViewController+appDelegateUser.h"
#import "BadgeCell.h"
#import "ImageLoader.h"

@interface BadgesViewController ()

@end

@implementation BadgesViewController

@synthesize badges;

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

-(void)refreshTable:(UIRefreshControl *)sender
{
	User *user = [self currentUser];
    [user refresh];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
}

- (void)loadData
{
    User *user = [self currentUser];
    badges = [[NSArray alloc] initWithArray:user.badges];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.badges count] > 0 ? [self.badges count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.badges count] == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
        cell.textLabel.text = @"No Badges Awarded Yet";
        return cell;
    } else {
        BadgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"badgeCell"];
    
        // Configure the cell...
        NSDictionary *badge = [self.badges objectAtIndex:indexPath.row];
        [cell.title setText:[badge objectForKey:@"name"]];
    
        CGSize maximumSize = CGSizeMake(190, 60);
        NSString *descriptionText = [badge objectForKey:@"description"];
        UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica" size:11];
        CGSize descriptionStringSize = [descriptionText sizeWithFont:descriptionFont 
                                                   constrainedToSize:maximumSize 
                                                       lineBreakMode:cell.detail.lineBreakMode];
    
        [cell.detail setText:descriptionText];
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[badge objectForKey:@"badge"]]];
        [cell.badge setImage:[ImageLoader loadImageFromURL:url usingCache:YES]];
        
        if(indexPath.row == 0){
            cell.badge.frame = CGRectMake(15, 20, 80, 80);
            cell.title.frame = CGRectMake(105, 20, 190, 21);
            cell.detail.frame = CGRectMake(105, 40, 190, descriptionStringSize.height);
        } else {
            cell.badge.frame = CGRectMake(15, 10, 80, 80);
            cell.title.frame = CGRectMake(105, 10, 190, 21);
            cell.detail.frame = CGRectMake(105, 30, 190, descriptionStringSize.height);
        }
        
        UIImageView *background;
        if(indexPath.row==0 && self.badges.count==1)
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
        else if(indexPath.row == 0)
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 1, 0)]];
        else if(indexPath.row == self.badges.count-1)
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 15, 0)]];
        else
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableMiddleBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 0)]];
    
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
        [background setClipsToBounds:true];
        cell.backgroundView = background;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([badges count]==0){
        return 100; 
    } else {
        int height = 100;
        if(indexPath.row == 0)
            height += 10;
        
        if(indexPath.row == self.badges.count-1)
            height+=10; 
        
        return height;
    }
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