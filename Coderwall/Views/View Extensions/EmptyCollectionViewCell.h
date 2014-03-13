//
//  EmptyCollectionViewCell.h
//  Coderwall
//
//  Created by Will Mckenzie on 12/03/2014.
//  Copyright (c) 2014 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyCollectionViewCell : UICollectionViewCell
{
    IBOutlet UILabel *__weak title;
}

@property (weak) UILabel *title;

@end
