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


#import "M10ScreenController.h"
#import <stdlib.h>                  // standard library of obj c methods (utility)

// Put this in to be able to contact the destination ViewController
#import "M20FileViewController.h"

@interface M10ScreenController ()

@end


@implementation M10ScreenController

// Synthesize the data transfer variables

@synthesize selectionName;
//@synthesize segueType;


- (void)viewDidLoad
{
    [super viewDidLoad];
        NSLog(@"M10ScreenController:viewDidLoad;self.window is %@", self.description);

    
    NSLog(@"M10ScreenController:viewDidLoad;iRAN ");
}

//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Prepare for Segue
// CALLED prior to a Storyboard segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"M10ScreenController : prepareforSegue Ran ****************************************************>>>>>>>>>>>>>>> ");
     NSLog(@"M10ScreenController : prepareForSegue ;segue identifier is ..........>>>>   %@    <<<..........................", segue.identifier);
    NSLog(@"M10ScreenController : prepareForSegue ; destination VC is ..........>>>>   %@    <<<..........................", segue.destinationViewController);
    // this code will allow a return to a null 
    if ([segue.identifier isEqualToString: @"RtnMainMenu"])
    {
        NSLog(@"M10ScreenController : Returning To Main Menu ");
 
    }
    else if ([segue.identifier isEqualToString: @"NotImplementedMenu"])
    {
        NSLog(@"M10ScreenController : Not Implemented Menu ");
       
    }
    else if ([segue.identifier isEqualToString: @"NonFileMenu"])
    {
        NSLog(@"M10ScreenController : Non File Related Menu ");
        
    }

    else // KEY SECTION; This code passes the Segue Identifier to the File View Controller
    {
        NSLog(@"M10ScreenController : ++++ FILE MENU +++ vc.segue.identifier is ..........>>>>   %@    <<<..........................", segue.identifier);
        M20FileViewController *vc = segue.destinationViewController;
        vc.selectedName = segue.identifier;
        NSLog(@"M10ScreenController : segue.destinationView Controller is M20FileViewController and selectedName IS ..........>>>>   %@    <<<..........................", vc.selectedName);
    }
    // else other buttons.
   

}

/*

- (IBAction)ShedBTN:(UIButton *)sender {
   segueType.description  = @"bull";
 
    
}*/
@end
