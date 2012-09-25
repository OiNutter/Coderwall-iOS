//
//  AccomplishmentsViewController.m
//  Coderwall
//
//  Created by Will on 20/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "AccomplishmentsViewController.h"
#import "User.h"
#import "UIViewController+appDelegateUser.h"
#import "AccomplishmentCell.h"

@implementation AccomplishmentsViewController

@synthesize accomplishments;

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
    accomplishments = [[NSArray alloc] initWithArray:user.accomplishments];   
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
    // Return the number of rows in the section.
    return [accomplishments count] > 0 ? [accomplishments count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([accomplishments count]==0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
        cell.textLabel.text = @"No Accomplishments Entered Yet";
        return cell;
    } else {
        AccomplishmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accomplishmentCell"];
        NSString *accomplishment = [accomplishments objectAtIndex:indexPath.row];
    
        CGSize maximumSize = CGSizeMake(280, 9999);
        UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica" size:12];
        CGSize descriptionStringSize = [accomplishment sizeWithFont:descriptionFont 
                                               constrainedToSize:maximumSize 
                                                   lineBreakMode:cell.detail.lineBreakMode];
    
        UIImageView *background;
    
        if(indexPath.row==0 && self.accomplishments.count==1)
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
        else if(indexPath.row == 0)
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 1, 0)]];
        else if(indexPath.row == self.accomplishments.count-1)
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 15, 0)]];
        else
            background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableMiddleBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 0)]];
        
                
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
        [background setClipsToBounds:true];
    
        if(indexPath.row == 0 && self.accomplishments.count == 1)
            cell.detail.frame = CGRectMake(20, 16, 280, descriptionStringSize.height);
        else if(indexPath.row ==0)
            cell.detail.frame = CGRectMake(20, 21, 280, descriptionStringSize.height);
        else
            cell.detail.frame = CGRectMake(20, 11, 280, descriptionStringSize.height);
    
        // Configure the cell...
        cell.backgroundView = background;
        cell.detail.text = accomplishment;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([accomplishments count]==0){
        return 100; 
    } else {
        AccomplishmentCell *cell = (AccomplishmentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        int height = cell.detail.frame.size.height + 22;
        if(indexPath.row == 0)
            height += 10;
    
        if(indexPath.row == self.accomplishments.count-1)
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
