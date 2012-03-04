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
#import "AccomplishmentCell.h"

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

- (AccomplishmentCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"accomplishmentCell";
    AccomplishmentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *accomplishment = [accomplishments objectAtIndex:indexPath.row];
    
    CGSize maximumSize = CGSizeMake(280, 9999);
    UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica" size:12];
    CGSize descriptionStringSize = [accomplishment sizeWithFont:descriptionFont 
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
    cell.detail.text = accomplishment;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccomplishmentCell *cell = (AccomplishmentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    int height = cell.detail.frame.size.height + 22;
    if(indexPath.row == 0)
        height += 10;
    
    if(indexPath.row == self.accomplishments.count-1)
        height+=10; 
    
    return height;
}

@end
