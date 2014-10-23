//
//  M1ScreenController.h ( future VCL1.h )
//  DrLouWSApp1
//
//  Created by picals on 5/16/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface M1ScreenController : UIViewController  {
    //IBOutlet UILabel *EmployeeScreenLabel;
    NSString* introString;
    
 }
// - (IBAction)empNotesBTN;
// these variables will hold and control the selection of this VC for transmission to the VCL2
//@property (nonatomic, strong) IBOutlet UILabel* selectionLabel;
@property (nonatomic, strong) NSString* selectionName;

@end
