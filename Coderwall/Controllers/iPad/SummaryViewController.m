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
#import "AppDelegateProtocol.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController

@synthesize statsData;
@synthesize sections;

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    User *user = [self currentUser];
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *stats;
    
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
    
    NSArray *profileData = [[NSArray alloc] initWithObjects:user.name,summaryDetails,[user getAvatar],nil];
    NSArray *profileKeys = [[NSArray alloc] initWithObjects:@"fullName",@"summary",@"avatar", nil];
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
    
    if(user.specialities != (id)[NSNull null]){
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"UserChanged" object:nil];
}

- (void)reloadTable
{
    [self viewDidLoad];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.frame = CGRectMake(-10, 0, 330, self.tableView.frame.size.height);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    if(indexPath.row==0 && numRows==1){
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }else if(indexPath.row == 0){
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 1, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }else if(indexPath.row == numRows-1){
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 15, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }else{
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableMiddleBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }
    [background setClipsToBounds:true];
    
    if((NSString *)[sections objectAtIndex:indexPath.section] == @"Profile"){
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
        NSArray *section = (NSArray *)[statsData objectAtIndex:indexPath.section];
        NSDictionary *item = (NSDictionary *)[section objectAtIndex:indexPath.row];
        cell.title.text = [item objectForKey:@"fullName"];
        cell.detail.text = [item objectForKey:@"summary"];
        [cell.avatar setImage:[item objectForKey:@"avatar"]];
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


@end
