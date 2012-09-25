//
//  AccomplishmentsiPadViewController.m
//  Coderwall
//
//  Created by Will on 04/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "AccomplishmentsiPadViewController.h"
#import "iPadAccomplishmentCell.h"

@interface AccomplishmentsiPadViewController ()

@end

@implementation AccomplishmentsiPadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadData
{
    [super loadData];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *newAccomplishments = [[NSMutableArray alloc] init ];
    
    int i = 0;
    NSMutableArray *row = [[NSMutableArray alloc] init ];
    for (NSDictionary *item in accomplishments) {
        [row addObject:item];
        i++;
        if(i==3){
            i=0;
            [newAccomplishments addObject:row];
            row = [[NSMutableArray alloc] init ];
        }
    }
    if(i<3 && i>0)
        [newAccomplishments addObject:row];
    
    accomplishments = [[NSArray alloc] initWithArray:newAccomplishments];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.parentViewController.navigationItem.title = @"Accomplishments";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.accomplishments count]==0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
        cell.textLabel.text = @"No Accomplishments Entered Yet";
        return cell;
    } else {
        iPadAccomplishmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accomplishmentsCell"];
    
        // Configure the cell...
        NSMutableArray *row = [self.accomplishments objectAtIndex:indexPath.row];
        UIImage *background = [[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];   
        CGSize maximumSize = CGSizeMake(190, 160);
        UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica" size:12];
    
        NSString *accomplishment1 = [row objectAtIndex:0];
        [cell.bg1 setImage: background];
        
        CGSize descriptionStringSize1 = [accomplishment1 sizeWithFont:descriptionFont 
                                                    constrainedToSize:maximumSize 
                                                        lineBreakMode:cell.detail1.lineBreakMode];
    
        [cell.detail1 setText:accomplishment1];
        cell.detail1.frame = CGRectMake(22, 30, 190, descriptionStringSize1.height);
    
        if(row.count >= 2){
            NSString *accomplishment2 = [row objectAtIndex:1];
            [cell.bg2 setImage: background];
        
            CGSize descriptionStringSize2 = [accomplishment2 sizeWithFont:descriptionFont 
                                                        constrainedToSize:maximumSize 
                                                            lineBreakMode:cell.detail2.lineBreakMode];
        
            [cell.detail2 setText:accomplishment2];
            cell.detail2.frame = CGRectMake(257, 30, 190, descriptionStringSize2.height);
        } else {
            [cell.detail2 setText:@""];
            [cell.bg2 setImage:Nil];
        }
    
        if(row.count >=3){
            NSString *accomplishment3 = [row objectAtIndex:2];
            
            [cell.bg3 setImage: background];
        
            CGSize descriptionStringSize3= [accomplishment3 sizeWithFont:descriptionFont 
                                                       constrainedToSize:maximumSize 
                                                           lineBreakMode:cell.detail3.lineBreakMode];
        
            [cell.detail3 setText:accomplishment3];
            cell.detail3.frame = CGRectMake(490, 30, 190, descriptionStringSize3.height);
        } else {
            [cell.detail3 setText:@""];
            [cell.bg3 setImage:Nil];
        }
    
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return [self.accomplishments count] > 0 ? 195 : 300;
}

@end
