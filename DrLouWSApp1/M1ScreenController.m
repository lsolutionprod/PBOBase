//
//  EmployeeScreenController.m  (future M1ScreenController.m)
//  DrLouWSApp1
//
//  Created by picals on 5/16/13.
//  Copyright (c) 2013 picals. All rights reserved.
//
//  This code is the level 1 menu controller.  Any button that is wired to a functional VC will use this code.
//  The PrepareForSegue code will read the "file name related" identifier on each segue to a particular screen to display the proper file.
// NOTES: this code will manage all the level 1 activity for this applicaion
// This code will eventually read a config file with metadata and manage which level 2 view controller will be called and control the passing
// of the data for all transactions.


#import "M1ScreenController.h"
#import <stdlib.h>                  // standard library of obj c methods (utility)

// Put this in to be able to contact the destination ViewController
#import "M20FileViewController.h"

@interface M1ScreenController ()

@end


@implementation M1ScreenController

// Synthesize the data transfer variables

@synthesize selectionName;


- (void)viewDidLoad
{
    [super viewDidLoad];
        NSLog(@"M1Controller:viewDidLoad;self.window is %@", self.description);

    
    NSLog(@"M1ScreenController:viewDidLoad;iRAN ");
}

//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Prepare for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"M1Controller : prepareforSegue Ran ****************************************************>>>>>>>>>>>>>>> ");
     NSLog(@"M1Controller : prepareForSegue ;segue identifier is ..........>>>>   %@    <<<..........................", segue.identifier);
    NSLog(@"M1Controller : prepareForSegue ; destination VC is ..........>>>>   %@    <<<..........................", segue.destinationViewController);
    // this code will allow a return to a null 
    if ([segue.identifier isEqualToString: @"RtnMainMenu"])
    {
        NSLog(@"M1Controller : Returning To Main Menu ");
 
    }
    else if ([segue.identifier isEqualToString: @"NotImplementedMenu"])
    {
        NSLog(@"M1Controller : Not Implemented Menu ");
       
    }
    else if ([segue.identifier isEqualToString: @"NonFileMenu"])
    {
        NSLog(@"M1Controller : Non File Related Menu ");
        
    }

    else // KEY SECTION; This code passes the Segue Identifier to the File View Controller
    {
        NSLog(@"M1Controller : ++++ FILE MENU +++ vc.segue.identifier is ..........>>>>   %@    <<<..........................", segue.identifier);
        M20FileViewController *vc = segue.destinationViewController;
        vc.selectedName = segue.identifier;
        NSLog(@"M1Controller : segue.destinationView Controller is M20FileViewController and selectedName IS ..........>>>>   %@    <<<..........................", vc.selectedName);
    }
    // else other buttons.
   

}



@end
