//
//  ViewController.h
//  DrLouWSApp1
//
//  Created by picals on 5/15/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController {
    IBOutlet UILabel *drlouWSMenulabel;
    // this label is now available in the connections inspector
}

-(IBAction)didPressLink;

@property (nonatomic,retain) IBOutlet UIButton* linkButton;

@end
