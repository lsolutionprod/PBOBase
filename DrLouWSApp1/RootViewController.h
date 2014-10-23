//
//  RootViewController.h
//  DrLouWSApp1
//
//  Created by picals on 6/20/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

@class DBRestClient;


@interface RootViewController : UIViewController {
    UIButton* linkButton;
    UIViewController* photoViewController;
	DBRestClient* restClient;
}
// this button used to link to DROPBOX
- (IBAction)didPressLink;

@property (nonatomic, retain) IBOutlet UIButton* linkButton;
@property (nonatomic, retain) UIViewController* photoViewController;

@end
