//
//  BadgeViewCell.h
//  Coderwall
//
//  Created by Will on 19/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeCell : UITableViewCell{
    IBOutlet UIImageView *__weak badge;
    IBOutlet UILabel *__weak title;
    IBOutlet UILabel *__weak detail;
}

@property (weak) UIImageView *badge;
@property (weak) UILabel *title;
@property (weak) UILabel *detail;

@end
