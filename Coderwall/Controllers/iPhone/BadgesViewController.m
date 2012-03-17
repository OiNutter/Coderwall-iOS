//
//  BadgesViewController.m
//  Coderwall
//
//  Created by Will on 19/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "BadgesViewController.h"
#import "User.h"
#import "AppDelegateProtocol.h"
#import "BadgeCell.h"

@interface BadgesViewController ()

@end

@implementation BadgesViewController

@synthesize badges;

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *user = [self currentUser];
    badges = [[NSArray alloc] initWithArray:user.badges];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"UserChanged" object:nil];
    
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
    [self viewDidLoad];
    [self.tableView reloadData];
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
        cell.textLabel.text = [[NSString alloc] initWithString:@"No Badges Awarded Yet"];
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
        //dispatch_queue_t badgeQueue = dispatch_queue_create("badge queue", NULL);
        //dispatch_async(badgeQueue,^{
        //   UIImage *badge = ;
        //        dispatch_async(dispatch_get_main_queue(),^{
                    [cell.badge setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:url]]];
                    //        });
                    //});
                    // dispatch_release(badgeQueue);
    
        UIImageView *background;
        if(indexPath.row == 0)
            background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableTopBg.png"]];
        else if(indexPath.row == self.badges.count-1)
            background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableBottomBg.png"]];
        else
            background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableMiddleBg.png"]];
    
        if(indexPath.row == 0){
            cell.badge.frame = CGRectMake(15, 20, 80, 80);
            cell.title.frame = CGRectMake(105, 20, 190, 21);
            cell.detail.frame = CGRectMake(105, 40, 190, descriptionStringSize.height);
        } else {
            cell.badge.frame = CGRectMake(15, 10, 80, 80);
            cell.title.frame = CGRectMake(105, 10, 190, 21);
            cell.detail.frame = CGRectMake(105, 30, 190, descriptionStringSize.height);
        }
    
        [background setContentMode:UIViewContentModeTop];
        cell.backgroundView = background;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 100;
    
    if((indexPath.row == 0 || indexPath.row == self.badges.count-1) && self.badges.count>0)
        height = 110;
    
    return height;
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