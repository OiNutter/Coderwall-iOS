//
//  ProfileCell.h
//  Coderwall
//
//  Created by Will on 03/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell
{
    IBOutlet UIImageView *avatar;
    IBOutlet UILabel *title;
    IBOutlet UILabel *detail;
}

@property UIImageView *avatar;
@property UILabel *title;
@property UILabel *detail;

@end
