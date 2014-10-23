//
//  AppDelegate.m
//  DrLouWSApp1 :
//
//  Created by picals on 5/15/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>
#import "ViewController.h"
#import "PhotoViewController.h"
#import "RootViewController.h"


@interface AppDelegate () <DBSessionDelegate, DBNetworkRequestDelegate>

@end


@implementation AppDelegate

@synthesize window;
@synthesize rootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set the DROPBOX credential variables before launching the app
    NSLog(@"DrLouWSApp1 :AppDelagate.m; didFinishLaunchingWithOptions Ran!");
    // KEYS Provided by Drop Box to access our file data on the CLOUD
    NSString* appKey = @"7mityvqzky3ylqu";
	NSString* appSecret = @"iq5yfl1v60jx8ia";
	NSString *root = kDBRootAppFolder; // Should be set to either kDBRootAppFolder or kDBRootDropbox
	// You can determine if you have App folder access or Full Dropbox along with your consumer key/secret
	// from https://dropbox.com/developers/apps
	
	// Look below where the DBSession is created to understand how to use DBSession in your app
	
	NSString* errorMsg = nil;
	if ([appKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"DrLouWSApp1 :AppDelagate.m RAN : Make sure you set the app key correctly in AppDelegate.m";
	} else if ([appSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"DrLouWSApp1 :AppDelagate.m RAN : Make sure you set the app secret correctly in AppDelegate.m";
	} else if ([root length] == 0) {
		errorMsg = @"DrLouWSApp1 :AppDelagate.m RAN : Set your root to use either App Folder of full Dropbox";
	} else {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
		NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
		NSDictionary *loadedPlist =
        [NSPropertyListSerialization
         propertyListFromData:plistData mutabilityOption:0 format:NULL errorDescription:NULL];
		NSString *scheme = [[[[loadedPlist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
		if ([scheme isEqual:@"db-APP_KEY"]) {
			errorMsg = @"Set your URL scheme correctly in DBRoulette-Info.plist";
		}
	}
	NSLog(@"DrLouWSApp1 :AppDelagate.m RAN : About to set the session object; Ran!");
	DBSession* session =
    [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
	session.delegate = self; // DBSessionDelegate methods allow you to handle re-authenticating
	[DBSession setSharedSession:session];
    [session release];
	
	[DBRequest setNetworkRequestDelegate:self];
    NSLog(@"DrLouWSApp1 :AppDelegate.m RAN : Session Object loaded!");
	if (errorMsg != nil) {
        NSLog(@"DrLouWSApp1 :AppDelegate.m RAN : Bonehead you got an error...!");

		[[[[UIAlertView alloc]
		   initWithTitle:@"Error Configuring Session" message:errorMsg
		   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
		  autorelease]
		 show];
       
	}
    else NSLog(@"No Errors!");
    
    
    return YES;
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"DrLouWSApp1 :AppDelagate.m:applicationWillResignActive Ran!");

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"DrLouWSApp1 :AppDelagate.m:applicationDidEnterBackground Ran!");

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"DrLouWSApp1 :AppDelagate.m:applicationWillEnterForeground Ran!");

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"DrLouWSApp1 :AppDelagate.m:applicationDidBecomeActive Ran!");

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"DrLouWSApp1 :AppDelagate.m:applicationWillTerminate Ran!");

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"DrLouWSApp1 :AppDelagate.m:DropBox Handle Open URL Ran!");
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"DrLouWSApp1 :App linked successfully!");
            // At this point you can start making API calls
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}



- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
    NSLog(@"DrLouWSApp1 :AppDelagate.m:sessionDidReceiveAuthorizationFailure Ran!");
	
    relinkUserId = [userId retain];
	[[[[UIAlertView alloc]
	   initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self
	   cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil]
	  autorelease]
	 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
    NSLog(@"DrLouWSApp1 :AppDelagate.m:alertView Ran!");
	
    if (index != alertView.cancelButtonIndex) {
		[[DBSession sharedSession] linkUserId:relinkUserId fromController:rootViewController];
	}
	[relinkUserId release];
	relinkUserId = nil;
}
static int outstandingRequests;

- (void)networkRequestStarted {
    NSLog(@"DrLouWSApp1 :AppDelagate.m:networkRequestStarted Ran!");

	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
    NSLog(@"DrLouWSApp1 :AppDelagate.m:networkRequestStopped Ran!");

	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

@end
