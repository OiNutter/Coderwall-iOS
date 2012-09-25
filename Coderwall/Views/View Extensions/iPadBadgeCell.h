//
//  iPadBadgeCellCell.h
//  Coderwall
//
//  Created by Will on 03/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadBadgeCell : UITableViewCell
{
    IBOutlet UIImageView *__weak badge1;
    IBOutlet UILabel *__weak title1;
    IBOutlet UILabel *__weak detail1;
    IBOutlet UIImageView *__weak bg1;

    IBOutlet UIImageView *__weak badge2;
    IBOutlet UILabel *__weak title2;
    IBOutlet UILabel *__weak detail2;
    IBOutlet UIImageView *__weak bg2;

    IBOutlet UIImageView *__weak badge3;
    IBOutlet UILabel *__weak title3;
    IBOutlet UILabel *__weak detail3;
    IBOutlet UIImageView *__weak bg3;

}

@property (weak) UIImageView *badge1;
@property (weak) UILabel *title1;
@property (weak) UILabel *detail1;
@property (weak) UIImageView *bg1;

@property (weak) UIImageView *badge2;
@property (weak) UILabel *title2;
@property (weak) UILabel *detail2;
@property (weak) UIImageView *bg2;

@property (weak) UIImageView *badge3;
@property (weak) UILabel *title3;
@property (weak) UILabel *detail3;
@property (weak) UIImageView *bg3;
@end
