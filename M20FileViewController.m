//
//  M20FileViewController.m
//  DrLouWSApp1
//
//  Created by picals on 5/16/13.
//  Copyright (c) 2013 picals. All rights reserved.
//  This view controller is the model for the L Solution Products  Custom Personal Organizer (CPO) application.
//  The purpose of this code is to allow a PDF file to be accessed from Dropbox(r) (or any other remote file system) and display the file on
//  the WEB VIEW panel in one of the specific "storyboard" view controllers.
//  Each of these view controller copies will be modified slightly to choose the type of file desired.
//  THIS VIEW CONTROLLER ACCEPTS THE NAME OF THE SEGUE THAT CALLED EACH VIEW CONTROLLER AND ATTEMPTS TO FIND A CORRESPONDING FILE IN THE TARGET DIRECTORY
//
//

#import <UIKit/UIKit.h>  // allows the Storyboard to work

#import "M20FileViewController.h"   // need to import the "interface file (.h) to make this code accessible to the rest of the system
#import <DropboxSDK/DropboxSDK.h>   // this is the DROPBOX tool kit, this contains code needed t communicate with DROPBOX
#import <stdlib.h>                  // standard library of obj c methods (utility)

// This View Controller will collect and display the "EMPLOYEE NOTES" file from DROPBOX and display it on the IOS device


@interface M20FileViewController () <DBRestClientDelegate>
  // this is to controll the Activity Indicator
  - (void)setWorking:(BOOL)isWorking;
// define the REST CLIENT used by DROPBOX (DBRestClient is in the Dropbox SDK)
@property (nonatomic, readonly) DBRestClient* restClient;


@end

// This View Controller will collect and display the "EMPLOYEE NOTES" file from DROPBOX and display it on the IOS device
@implementation M20FileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"M20FileViewController: initwithNibName Ran!");
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // NEED TO FIND OUT RIGHT HERE - WHAT BUTTON WAS PUSHED TO GET HERE
    //NSLog(@"M20FileViewController: VIEW DID LOAD RAN  **********==========>>>M20FileViewController:viewDidLoad;introString is ------> %@", introString );
    //NSLog(@"M20FileViewController: viewDidLoad;self.introString is %@", self.introString);
    NSLog(@"M20FileViewController: viewDidLoad;self.selectedName is %@", self.selectedName);

    [super viewDidLoad];
    NSLog(@"M20FileViewController: viewDidLoad about to call loadMetadata!");

    
    // Call the REST client to load directory information about the ROOT directory targeted by Dropbox App settings.
    // The Dropbox app will call back to "restClient loadedMetadata" 
    [self.restClient loadMetadata:@"/"];
    
    
    NSLog(@"M20FileViewController: viewDidLoad Ran!");
	
  }
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setWorking:(BOOL)isWorking {
    if (working == isWorking) return;
    working = isWorking;
    
    if (working) {
        [activityIndicator startAnimating];
    } else {
        [activityIndicator stopAnimating];
    }
    //nextButton.enabled = !working;
}
// Synthesize the UI Web View
@synthesize ENotesWebview2;
// set up the activity indicator (NOT USED)
@synthesize activityIndicator;

// test data passed
//@synthesize introString;
//NAME OF BUTTON PRESSED
@synthesize selectedName;


// REST CLIENT OVERLOADED FUNCTIONS


//CALL BACK METHOD called from DROPBOX to collect the metadata (file names and such) about our current directory then download the file.
// This responds to the call made in "viewDidLoad: restClient loadMetadata;
- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata
{
    NSString* metastring = metadata.filename;
    NSLog(@"M20FileViewController:restClient:loadedMetadata Ran! %@", metastring );
    
    //collect the files with "pdf  in the filenames
    // KEY CHANGE AREA; - defines PDF as the type of file to use - if we choose other types, we'll put in later
    NSArray* validExtensions = [NSArray arrayWithObjects:@"pdf",@"docx",@"xlsx", nil];
    
    // allows for multiple file names, but we'll only use one here (I'll remove some of this later)
    NSMutableArray* newFilePaths = [NSMutableArray new];
    for (DBMetadata* child in metadata.contents) {
        NSString* extension = [[child.path pathExtension] lowercaseString];
        NSLog(@"M20FileViewController:restClient:loadedMetadata:before if statement;child.path is %@", child.path );
       
        
        if (!child.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
            [newFilePaths addObject:child.path];
            NSLog(@"M20FileViewController:restClient:loadedMetadata:in if statement ;child.path is %@", child.path );

        }
    NSLog(@"M20FileViewController:restClient:loadedMetadata;newFilePaths is %@", newFilePaths );
       
    }
    // we have the path now we'll try to get the file.

    
    // gets the first filename with path  (CHANGE THIS TO SELECT THE FILE YOU WANT)
    // FILE SELECTION LOGIC WILL GO HERE
    //   this code will test for a match of the proper file name against a list of files and determine the proper index of the matching filename
    //   this index will be set to selection and the code will load the proper file to the web view screen (or other interface)
    //   FUTURE Development: a config file will be used to manage the relationships between seques and the file names. (dynamic segue names?)
    
    
    NSInteger selection = 0;
    
    //NSUInteger selectedByName = [newFilePaths indexOfObject: @"EMPLOYEE1.docx"];
    
    
    // this code will find the index of a file name
    
    NSString *haystackText = selectedName;
    NSLog(@"M20FileViewController: FIND INDEX TEST  loadedmetadata; haystackText is %@", haystackText);
    BOOL foundAFile = false;
    int totalElements = [newFilePaths count];
    for(int i=0; i < totalElements; i++)
    {
        BOOL result = [haystackText caseInsensitiveCompare:[newFilePaths objectAtIndex:i]] == NSOrderedSame;
                       if(result)
                       {
                           NSUInteger fooIndex = [newFilePaths indexOfObject: haystackText];
                           NSLog(@"M20FileViewController: FIND INDEX  loadedmetadata;selectedByName is %lu", (unsigned long)fooIndex);
                           selection = fooIndex;
                           foundAFile = true;
                       }
                        //  ERROR HANDLER CODE IN CASE WE DON'T FIND A FILENAME MATCH
                       else
                       {
                           
                           NSLog(@"M20FileViewController: FIND INDEX OBJECT NOT FOUND  loadedmetadata;haystackText is %@", haystackText);
                           // this will issue a pop up if the file name is not there.
                           // the most likely cause is corruption in the file system
                           // the name of the files do not match the config or segue names exactly
                             
                       }
    }
    if (!foundAFile)
    {
        [[[[UIAlertView alloc]
           initWithTitle:@"DrLouWS1:File Requested Was Not Found" message:@"Please Return to Main Menu and Try Another File; If the problem continues check your file names or contact support.  Thanks" delegate:self
           cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil]
          autorelease]
         show];
        // need a solution for this case where the file is not found... a default file needs to be selected.
    }
    
    // this code determines what file will be selected by the NSInteger selection variable
    // we want this to be set based on knowing the file name is match for the right one we are looking for.
    NSLog(@"M20FileViewController:restClient:loadedMetadata;selection is %ld", (long)selection);
 
    NSString* DBpath = [newFilePaths objectAtIndex:selection ];
    
    NSLog(@"M20FileViewController:restClient:loadedMetadata;DBPath is %@", DBpath );
    selectedFile = DBpath;
    
    NSString *filename = [metadata.path lastPathComponent];
    
    NSLog(@"M20FileViewController:restClient:loadedMetadata;filename is %@", filename );
    
    // set up the loadFile call to DROPBOX by loading the source and destination of the file
    NSLog(@"M20FileViewController:restClient:loadedMetadata;newFilePaths is %@ , about to call loadFile", newFilePaths );
    // find the local destination for the file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    // create the placeholder for the file in the local directory
    // KEY CHANGE AREA - must pick the name of the file (could be added later with config screen)
    NSLog(@"M20FileViewController:restClient:loadedMetadata;selectedFile is %@", selectedFile );

    // CHANGE THIS TO PICK THE EXACT FILE NAME
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:selectedFile];
    //NSError *error;
    NSLog(@"M20FileViewController:==========>>>restClient:loadedMetadata;loadFile is %@ , about to call loadFile", filePath );
    
    // call the DROPBOX and request the file to be loaded - This will CALL BACK on restClient:loadedFile 
    [[self restClient] loadFile:DBpath intoPath:filePath];
    
    NSLog(@"M20FileViewController: restClient:loadedMetadata ran loadFile ");
}

//CALL BACK  methods from DROPBOX for file collection here is where we'll try to load our file and display it
// this responds to the restClient loadFile command in client:loadedMetadata;
- (void)restClient:(DBRestClient*)client loadedFile:(NSString *)localPath {
    NSLog(@"M20FileViewController: restClient:loadedFile: %@", localPath);
    
    // create a url with the local path returned
    NSURL *url = [NSURL fileURLWithPath:localPath];
    NSLog(@"M20FileViewController: restClient:loadedFile:url is ; %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"M20FileViewController: restClient:loadedFile:request is;  %@", request);
    // load the file into the WebView instance
    [ENotesWebview2 loadRequest:request];
    [ENotesWebview2 setScalesPageToFit:YES];
        
    //[self displayError];
    //[self setWorking:NO];
}

// ERROR BASED CALLBACKS
- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
    NSLog(@"M20FileViewController: restClient:loadFileFailedWithError: %@", [error localizedDescription]);
    [self setWorking:NO];
    [self displayError];
}
- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"M20FileViewController: restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
    [self displayError];
    [self setWorking:NO];
}
- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
    [self setWorking:NO];
    [self displayError];
}
- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
    //[self loadRandomPhoto];
}

// UNUSED METHOD - WILL REMOVE LATER BUT COULD BE USED POTENTIALLY LATER
- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath {
    [self setWorking:NO];
    NSLog(@"M20FileViewController: restClient:client:loadedThumbnail Ran! %@", destPath );
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"EmpFile" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:destPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [ENotesWebview2 loadRequest:request];
    [ENotesWebview2 setScalesPageToFit:YES];
}

// main restClient instance
- (DBRestClient*)restClient {
    NSLog(@"M20FileViewController: ViewController:restClient - MAIN Client Method Ran ");
    
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}


- (void)displayError {
    [[[[UIAlertView alloc]
       initWithTitle:@"Error Loading File" message:@"There was an error loading your file."
       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
      autorelease]
     show];
   NSLog(@"M20FileViewController: displayError Method Ran ");
}


@end

