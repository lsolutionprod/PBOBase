//
//  RootViewController.m
//  DrLouWSApp1
//
//  Created by picals on 6/20/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import "RootViewController.h"
#import <DropboxSDK/DropboxSDK.h>


@interface RootViewController ()

- (void)updateButtons;

@end


@implementation RootViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.title = @"Link Account";
    }
    NSLog(@"RootViewController initWithCoder Ran!");

    return self;
}

- (void)didPressLink {
    NSLog(@"RootViewController didPressLink Ran!");
    if (![[DBSession sharedSession] isLinked]) {
		[[DBSession sharedSession] linkFromController:self];
    } else {
        [[DBSession sharedSession] unlinkAll];
        [[[[UIAlertView alloc]
           initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked"
           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
          autorelease]
         show];
        [self updateButtons];
    }
}

- (IBAction)didPressPhotos {
    [self.navigationController pushViewController:photoViewController animated:YES];
    NSLog(@"RootViewController didPressPhotos Ran!");

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateButtons];
    NSLog(@"RootViewController viewWillAppear Ran!");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithTitle:@"Photos" style:UIBarButtonItemStylePlain
                                               target:self action:@selector(didPressPhotos)] autorelease];
    self.title = @"Link Account";
    NSLog(@"RootViewController viewDidLoad Ran!");

}

- (void)viewDidUnload {
    [linkButton release];
    linkButton = nil;
    NSLog(@"RootViewController viewDidUnload Ran!");

}

- (void)dealloc {
    [linkButton release];
    [photoViewController release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return toInterfaceOrientation == UIInterfaceOrientationPortrait;
    } else {
        return YES;
    }
    NSLog(@"RootViewController shouldAutorotate Ran!");

}


#pragma mark private methods

@synthesize linkButton;
@synthesize photoViewController;

- (void)updateButtons {
    NSString* title = [[DBSession sharedSession] isLinked] ? @"Unlink Dropbox" : @"Link Dropbox";
    [linkButton setTitle:title forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem.enabled = [[DBSession sharedSession] isLinked];
    NSLog(@"RootViewController updateButtons Ran!");

}

@end

