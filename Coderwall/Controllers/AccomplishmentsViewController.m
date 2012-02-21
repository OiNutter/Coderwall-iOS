//
//  AccomplishmentsViewController.m
//  Coderwall
//
//  Created by Will on 20/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "AccomplishmentsViewController.h"
#import "User.h"
#import "AppDelegateProtocol.h"
#import "AccomplishmentsViewCell.h"

@interface AccomplishmentsViewController ()

@end

@implementation AccomplishmentsViewController

@synthesize accomplishments;

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
    accomplishments = [[NSArray alloc] initWithArray:user.accomplishments];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [accomplishments count];
}

- (AccomplishmentsViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"accomplishmentCell";
    AccomplishmentsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *accomplishment = [accomplishments objectAtIndex:indexPath.row];
    
    CGSize maximumSize = CGSizeMake(280, 9999);
    NSString *descriptionText = accomplishment;
    UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica" size:12];
    CGSize descriptionStringSize = [descriptionText sizeWithFont:descriptionFont 
                                               constrainedToSize:maximumSize 
                                                   lineBreakMode:cell.detail.lineBreakMode];
    
    UIImageView *background;
    
    if(indexPath.row==0 && self.accomplishments.count==1){
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }else if(indexPath.row == 0){
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 1, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }else if(indexPath.row == self.accomplishments.count-1){
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 15, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }else{
        background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TableMiddleBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 0)]];
        [background setContentMode:UIViewAutoresizingFlexibleHeight];
    }
    
    [background setClipsToBounds:true];
    
    if(indexPath.row == 0 && self.accomplishments.count == 1)
        cell.detail.frame = CGRectMake(20, 16, 280, descriptionStringSize.height);
    else if(indexPath.row ==0)
        cell.detail.frame = CGRectMake(20, 21, 280, descriptionStringSize.height);
    else
        cell.detail.frame = CGRectMake(20, 11, 280, descriptionStringSize.height);
    
    // Configure the cell...
    cell.backgroundView = background;
    cell.detail.text = descriptionText;
    
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
    AccomplishmentsViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    int height = cell.detail.frame.size.height + 22;
    NSLog([NSString stringWithFormat:@"%i"]);
    if(indexPath.row == 0 || indexPath.row == self.accomplishments.count-1)
        height += 10;
    
    
    
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
