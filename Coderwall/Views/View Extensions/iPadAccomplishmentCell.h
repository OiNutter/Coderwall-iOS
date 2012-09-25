//
//  iPadAccomplishmentCell.h
//  Coderwall
//
//  Created by Will on 04/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadAccomplishmentCell : UITableViewCell
{
    IBOutlet UILabel *detail1;
    IBOutlet UIImageView * bg1;
    
    IBOutlet UILabel *detail2;
    IBOutlet UIImageView * bg2;
    
    IBOutlet UILabel *detail3;
    IBOutlet UIImageView * bg3;
}

@property  UILabel *detail1;
@property  UIImageView *bg1;

@property  UILabel *detail2;
@property  UIImageView *bg2;

@property  UILabel *detail3;
@property  UIImageView *bg3;

@end
