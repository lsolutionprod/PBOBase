//
//  PhotoViewController.h
//  DrLouWSApp1
//
//  Created by picals on 6/20/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

@class DBRestClient;

@interface PhotoViewController : UIViewController {
    UIImageView* imageView;
    UIButton* nextButton;
    UIActivityIndicatorView* activityIndicator;
    
    NSArray* photoPaths;
    NSString* photosHash;
    NSString* currentPhotoPath;
    BOOL working;
    DBRestClient* restClient;
}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UIButton* nextButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;

@end
