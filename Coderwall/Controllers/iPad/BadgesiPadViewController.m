//
//  BadgesiPadViewController.m
//  Coderwall
//
//  Created by Will on 02/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "BadgesiPadViewController.h"
#import "iPadBadgeCell.h"

@interface BadgesiPadViewController ()

@end

@implementation BadgesiPadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *newBadges = [[NSMutableArray alloc] init ];
    
    int i = 0;
    NSMutableArray *row = [[NSMutableArray alloc] init ];
    for (NSDictionary *item in badges) {
        [row addObject:item];
        i++;
        if(i==3){
            i=0;
            [newBadges addObject:row];
            row = [[NSMutableArray alloc] init ];
        }
    }
    if(i<3 && i>0)
        [newBadges addObject:row];
    
    badges = [[NSArray alloc] initWithArray:newBadges];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"UserChanged" object:nil];
}

- (void)reloadTable
{
    [self viewDidLoad];
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.parentViewController.navigationItem.title = [[NSString alloc] initWithString:@"Badges"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"badgeCell";
    iPadBadgeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSMutableArray *row = [self.badges objectAtIndex:indexPath.row];
    UIImage *background = [[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];   
    CGSize maximumSize = CGSizeMake(190, 60);
    UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica" size:11];
    CGSize descriptionStringSize;

    NSDictionary *badge1 = [row objectAtIndex:0];
    [cell.title1 setText:[badge1 objectForKey:@"name"]];
    NSURL *url1= [NSURL URLWithString:[NSString stringWithFormat:@"%@",[badge1 objectForKey:@"badge"]]];
    [cell.badge1 setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:url1]]];
    [cell.bg1 setImage: background];

    NSString *descriptionText1= [badge1 objectForKey:@"description"];
    descriptionStringSize = [descriptionText1 sizeWithFont:descriptionFont 
                                               constrainedToSize:maximumSize 
                                                   lineBreakMode:cell.detail1.lineBreakMode];
    
    [cell.detail1 setText:descriptionText1];
    cell.detail1.frame = CGRectMake(25, 232, 190, descriptionStringSize.height);
    
    if(row.count >= 2){
        NSDictionary *badge2 = [row objectAtIndex:1];
        [cell.title2 setText:[badge2 objectForKey:@"name"]];
        NSURL *url2= [NSURL URLWithString:[NSString stringWithFormat:@"%@",[badge2 objectForKey:@"badge"]]];
        [cell.badge2 setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:url2]]];
        [cell.bg2 setImage: background];
        
        NSString *descriptionText2= [badge2 objectForKey:@"description"];
        descriptionStringSize = [descriptionText2 sizeWithFont:descriptionFont 
                                             constrainedToSize:maximumSize 
                                                 lineBreakMode:cell.detail2.lineBreakMode];
        
        [cell.detail2 setText:descriptionText2];
        cell.detail2.frame = CGRectMake(256, 232, 190, descriptionStringSize.height);
    } else {
        [cell.title2 setText:@""];
        [cell.detail2 setText:@""];
        [cell.badge2 setImage:Nil];
        [cell.bg2 setImage:Nil];
    }
    
    if(row.count >=3){
        NSDictionary *badge3 = [row objectAtIndex:2];
        [cell.title3 setText:[badge3 objectForKey:@"name"]];
        NSURL *url3= [NSURL URLWithString:[NSString stringWithFormat:@"%@",[badge3 objectForKey:@"badge"]]];
        [cell.badge3 setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:url3]]];
        [cell.bg3 setImage: background];
        
        NSString *descriptionText3= [badge3 objectForKey:@"description"];
        descriptionStringSize = [descriptionText3 sizeWithFont:descriptionFont 
                                             constrainedToSize:maximumSize 
                                                 lineBreakMode:cell.detail3.lineBreakMode];
        
        [cell.detail3 setText:descriptionText3];
        cell.detail3.frame = CGRectMake(485, 232, 190, descriptionStringSize.height);
    } else {
        [cell.title3 setText:@""];
        [cell.detail3 setText:@""];
        [cell.badge3 setImage:Nil];
        [cell.bg3 setImage:Nil];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 300;
}

@end
