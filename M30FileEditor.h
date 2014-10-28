//
//  M30FileEditor.h
//  PBOV1
//
//  Created by picals on 10/27/14.
//  Copyright (c) 2014 picals. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>


@interface M30FileEditor : ViewController

@property (strong, nonatomic) IBOutlet UITextField *enterName;
@property (strong, nonatomic) IBOutlet UITextField *enterDate;
@property (strong, nonatomic) IBOutlet UITextField *enterTime;
- (IBAction)saveData:(id)sender;
- (IBAction)searchData:(id)sender;
- (IBAction)retractKeyboard:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *resultView;


@end
