//
//  DrLousWebsitesController.m
//  DrLouWSApp1
//
//  Created by picals on 5/18/13.
//  Copyright (c) 2013 picals. All rights reserved.
//

#import "DrLousWebsitesController.h"

@implementation DrLousWebsitesController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)goToWingShop:(id)sender {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.drlouswingshop.com"]];
    
}
-(IBAction)goToWingSauce:(id)sender {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.drlousauce.com"]];
    
}
-(IBAction)goToDLP:(id)sender {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.drlousplace.com"]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
