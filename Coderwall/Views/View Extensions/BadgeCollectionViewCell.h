//
//  BadgeCollectionViewCell.h
//  Coderwall
//
//  Created by Will Mckenzie on 12/03/2014.
//  Copyright (c) 2014 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeCollectionViewCell : UICollectionViewCell
{
    IBOutlet UIImageView *__weak badge;
    IBOutlet UILabel *__weak title;
    IBOutlet UILabel *__weak detail;
}

@property (weak) UIImageView *badge;
@property (weak) UILabel *title;
@property (weak) UILabel *detail;

@end
