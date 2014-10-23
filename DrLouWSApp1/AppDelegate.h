//
//  AppDelegate.h
//  DrLouWSApp1
//
//  Created by picals on 5/15/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
     
    UIWindow *window;
    RootViewController *rootViewController;
    ViewController *viewController;
    NSString *relinkUserId;
   
}


@property (strong, nonatomic,retain) UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end
