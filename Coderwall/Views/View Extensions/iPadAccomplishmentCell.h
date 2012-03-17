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
    IBOutlet UILabel *__weak detail1;
    IBOutlet UIImageView *__weak bg1;
    
    IBOutlet UILabel *__weak detail2;
    IBOutlet UIImageView *__weak bg2;
    
    IBOutlet UILabel *__weak detail3;
    IBOutlet UIImageView *__weak bg3;
}

@property (weak) UILabel *detail1;
@property (weak) UIImageView *bg1;

@property (weak) UILabel *detail2;
@property (weak) UIImageView *bg2;

@property (weak) UILabel *detail3;
@property (weak) UIImageView *bg3;

@end
