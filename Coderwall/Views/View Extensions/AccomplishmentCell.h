//
//  AccomplishmentsViewCell.h
//  Coderwall
//
//  Created by Will on 20/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccomplishmentCell : UITableViewCell
{
    IBOutlet UILabel *__weak detail;
    IBOutlet NSLayoutConstraint *__weak textHeight;
}
@property (weak) UILabel *detail;
@property (weak) NSLayoutConstraint *textHeight;

@end
