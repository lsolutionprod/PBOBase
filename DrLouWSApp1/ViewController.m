//
//  ViewController.m
//  DrLouWSApp1
//
//  Created by picals on 5/15/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import "ViewController.h"
#import <DropboxSDK/DropboxSDK.h>


@interface ViewController () 
@end

@implementation ViewController


- (void)viewDidLoad
{
    NSLog(@"ViewController.m - viewDid Load Ran ");

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
       
       
}
- (IBAction)loginPresse:(UIButton *)sender {
    NSLog(@"Dropbox Check on Login ");
    if (![[DBSession sharedSession] isLinked]) {
        NSLog(@"Dropbox Trying to Login ");
		[[DBSession sharedSession] linkFromController:self];
    } else {
        [[DBSession sharedSession] unlinkAll];
        [[[[UIAlertView alloc]
           initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked"
           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
          autorelease]
         show];
       // [self updateButtons];
    }

}

-(void)didPressLink {
   // DBLoginController* controller = [[DBLoginController new] autorelease];
   // [controller presentFromController:self];
    NSLog(@"Dropbox Tried to LINK ");
    if(![[DBSession sharedSession] isLinked]) {
         [[DBSession sharedSession]linkFromController:self];
     }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
