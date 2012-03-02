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
    badges = [[NSArray alloc] initWithArray:user.badges];
    NSMutableArray *refreshes = [self refreshes];
    [refreshes removeObject:@"Badges"];
    [self setRefreshes:refreshes];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray *refreshes = [self refreshes];
    NSInteger index = [refreshes indexOfObject:@"Badges"];
    if(index != NSNotFound){
        [self viewDidLoad];
        [self.tableView reloadData];
    }
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
    return [self.badges count];
}

- (BadgeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"badgeCell";
    BadgeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
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
    [cell.badge setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:url]]];
    
    UIImageView *background;
    if(indexPath.row == 0){
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableTopBg.png"]];
    }else if(indexPath.row == self.badges.count-1){
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableBottomBg.png"]];
    }else{
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableMiddleBg.png"]];
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 100;
    
    if(indexPath.row == 0 || indexPath.row == self.badges.count-1)
        height = 110;
    
    return height;
}


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
