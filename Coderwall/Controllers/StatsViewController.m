//
//  StatsViewControllerViewController.m
//  Coderwall
//
//  Created by Will on 21/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "StatsViewController.h"
#import "AppDelegateProtocol.h"
#import "User.h"
#import "StatCell.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

@synthesize statsData;
@synthesize sections;

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (NSMutableArray *)refreshes
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	NSMutableArray *refreshes = (NSMutableArray*) theDelegate.refreshes;
	return refreshes;
}

- (void)setRefreshes:(NSMutableArray *)refreshes
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    [theDelegate setRefreshes:refreshes];
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
    
    NSMutableArray *refreshes = [self refreshes];
    [refreshes removeObject:@"Stats"];
    [self setRefreshes:refreshes];
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray *refreshes = [self refreshes];
    NSInteger index = [refreshes indexOfObject:@"Stats"];
    if(index != NSNotFound){
        [self viewDidLoad];
        [self.tableView reloadData];
    }
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (StatCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    return height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
