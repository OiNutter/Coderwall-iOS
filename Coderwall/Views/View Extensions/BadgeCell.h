//
//  BadgeViewCell.h
//  Coderwall
//
//  Created by Will on 19/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeCell : UITableViewCell{
    IBOutlet UIImageView *badge;
    IBOutlet UILabel *title;
    IBOutlet UILabel *detail;
}

@property UIImageView *badge;
@property UILabel *title;
@property UILabel *detail;

@end
