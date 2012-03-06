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
        [cell.badge setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:url]]];
    
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

@end
