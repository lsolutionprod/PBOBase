//  OBSOLETE FOR DLWS APP1//
//  M21FileViewController.h
//  DrLouWSApp1
//
//  Created by picals on 5/16/13.
//  Copyright (c) 2013 picals. All rights reserved.
//  OBSOLETE FOR DLWS APP1
//
//  This view controller is the model for the L Solution Products  Custom Personal Organizer (CPO) application.
//  The purpose of this code is to allow a PDF file to be accessed from Dropbox(r) (or any other remote file system) and display the file on
//  the WEB VIEW panel in one of the specific "storyboard" view controllers.
//  Each of these view controller copies will be modified slightly to choose the type of file desired.
//  THIS VIEW CONTROLLER SPECIFICALLY TARGETS THE FILE "EMPLOYEE.PDF" in the DLWSOrg001 directory in the APPS folder.
//


#import <UIKit/UIKit.h>  // allows the Storyboard to work
//global variable to use for selecting the file we want to show
extern int Selection;


@class DBRestClient;     // we have to define the REST CLIENT from DROPBOX
@class Empnotes;

// This View Controller will collect and display the "EMPLOYEE NOTES" file from DROPBOX and display it on the IOS device
@interface M21FileViewController : UIViewController {
    
    // we may have to define a number of these, one for each screen we create, I hope not...
    // define the Interface Builder Outlet for the User Interface Web View that is created in our view controller.
    __weak IBOutlet UIWebView *ENotesWebview2;
    
    // this is an activity indicator that we have to implement in order for it to show we're working when searching for a file
    UIActivityIndicatorView* activityIndicator;
    // determines if we are searching or doing some work
    BOOL working;
    // The REST Client from DROPBOX - REST = REpresentational State Transfer - which is an HTTP (GET, PUT, etc.) with the arguments in the URL.
    
    DBRestClient* restClient;
    Empnotes* empNotes;
    NSString* introString;
    
}
// May have to define a number of Webview items...

@property (nonatomic, retain) IBOutlet UIWebView* ENotesWebview2;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;
//@property (nonatomic, retain) IBOutlet UIImageView* imageView;  // could be used for photo display in future
@property (nonatomic, retain) NSString *introString;

@end
