//
//  ProfileCell.h
//  Coderwall
//
//  Created by Will on 03/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"

@interface ProfileCell : UITableViewCell
{
    IBOutlet AvatarView *__weak avatar;
    IBOutlet UILabel *__weak title;
    IBOutlet UILabel *__weak detail;
}

@property (weak) AvatarView *avatar;
@property (weak) UILabel *title;
@property (weak) UILabel *detail;

@end
