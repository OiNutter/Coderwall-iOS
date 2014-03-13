//
//  ProfileViewController.h
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "AvatarView.h"

@interface ProfileViewController : UIViewController <UIScrollViewDelegate, EGORefreshTableHeaderDelegate>
{
    IBOutlet UILabel *fullName;
    IBOutlet UILabel *summary;
    IBOutlet AvatarView *avatar;
    IBOutlet UIScrollView *profileScrollView;
    
    UIRefreshControl *_ios6RefreshHeaderView;

    EGORefreshTableHeaderView *_refreshHeaderView;

    
    
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}

@end
