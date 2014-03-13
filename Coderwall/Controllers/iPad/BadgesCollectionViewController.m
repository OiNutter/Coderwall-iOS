//
//  BadgesCollectionViewController.m
//  Coderwall
//
//  Created by Will Mckenzie on 12/03/2014.
//  Copyright (c) 2014 Bearded Apps. All rights reserved.
//

#import "BadgesCollectionViewController.h"
#import <BadgeCollectionViewCell.h>
#import <EmptyCollectionViewCell.h>
#import <User.h>
#import <UIViewController+appDelegateUser.h>
#import <ImageLoader.h>

@interface BadgesCollectionViewController ()

@end

@implementation BadgesCollectionViewController

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
		
        //if (![UIRefreshControl class]) {
            
            EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.collectionView.bounds.size.height, self.view.frame.size.width, self.collectionView.bounds.size.height)];
            view.delegate = self;
            view.backgroundColor = [UIColor clearColor];
            [self.collectionView addSubview:view];
            _refreshHeaderView = view;
            
            [_refreshHeaderView refreshLastUpdatedDate];
            
        /*} else {
            
            _ios6RefreshHeaderView = [[UIRefreshControl alloc]init];
            [_ios6RefreshHeaderView addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged UIControlEventValueChanged];
            [self.collectionView addSubview:_ios6RefreshHeaderView];
            
		}*/
	}
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        self.navigationController.navigationBar.tintColor = cwDarkGreyColor;
    else
        self.navigationController.navigationBar.barTintColor = cwDarkGreyColor;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self loadData];
}

-(void)refreshTable:(UIRefreshControl *)sender
{
	User *user = [self currentUser];
    [user refresh];
    [self performSelector:@selector(doneLoadingCollectionViewData) withObject:nil afterDelay:0];
}

- (void)loadData
{
    User *user = [self currentUser];
    badges = [[NSArray alloc] initWithArray:user.badges];
}

- (void)reloadTable
{
    [self loadData];
    [self.collectionView reloadData];
    _reloading = NO;
}

-(void)resetReloading
{
    [self performSelector:@selector(doneLoadingCollectionViewData) withObject:nil afterDelay:0];
    _reloading = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.badges count] > 0 ? [self.badges count] : 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.badges count] == 0){
        EmptyCollectionViewCell *cell = (EmptyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"emptyCell" forIndexPath:indexPath];
        [cell.title setText:@"No Badges Awarded Yet"];
        return cell;
    } else {
        BadgeCollectionViewCell *cell = (BadgeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell" forIndexPath:indexPath];
        NSDictionary *badge = [self.badges objectAtIndex:indexPath.item];
    
        NSString *descriptionText = [badge objectForKey:@"description"];
        
        [cell.title setText:[badge objectForKey:@"name"]];
        [cell.detail setText:descriptionText];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[badge objectForKey:@"badge"]]];
        [cell.badge setImage:[ImageLoader loadImageFromURL:url usingCache:YES]];
    
        return cell;
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)doneLoadingCollectionViewData{
	
	//  model should call this when its done loading
    if (_refreshHeaderView != nil)
    {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
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
    [self performSelector:@selector(doneLoadingCollectionViewData) withObject:nil afterDelay:0];
    
}

- (BOOL) egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
	return _reloading; // should return if data source model is reloading
    
}

- (NSDate*) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
	return [NSDate date]; // should return date data source was last changed
    
}


@end
