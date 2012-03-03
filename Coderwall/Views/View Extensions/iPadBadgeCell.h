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
    IBOutlet UIImageView *badge1;
    IBOutlet UILabel *title1;
    IBOutlet UILabel *detail1;
    IBOutlet UIImageView *bg1;

    IBOutlet UIImageView *badge2;
    IBOutlet UILabel *title2;
    IBOutlet UILabel *detail2;
    IBOutlet UIImageView *bg2;

    IBOutlet UIImageView *badge3;
    IBOutlet UILabel *title3;
    IBOutlet UILabel *detail3;
    IBOutlet UIImageView *bg3;

}

@property UIImageView *badge1;
@property UILabel *title1;
@property UILabel *detail1;
@property UIImageView *bg1;

@property UIImageView *badge2;
@property UILabel *title2;
@property UILabel *detail2;
@property UIImageView *bg2;

@property UIImageView *badge3;
@property UILabel *title3;
@property UILabel *detail3;
@property UIImageView *bg3;
@end
