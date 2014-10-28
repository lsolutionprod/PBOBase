//
//  M30FileEditor.m
//  PBOV1
//
//  Created by picals on 10/27/14.
//  Copyright (c) 2014 picals. All rights reserved.
//

#import "M30FileEditor.h"

@interface M30FileEditor ()

@end

@implementation M30FileEditor
// Data display elements
@synthesize resultView;
@synthesize enterName;
@synthesize enterDate;
@synthesize enterTime;


//Allows the keyboard to be retracted after typing
- (IBAction)retractKeyboard:(id)sender{
    [self resignFirstResponder];
    NSLog(@"M30FileEditor:retractKeyboard Ran! ");
}
// function of the Save Data Button
- (IBAction)saveData:(id)sender {
    NSLog(@"M30FileEditor:saveData Ran! ");
    NSString *resultLine =[NSString stringWithFormat:@"%@,%@,%@\n",
                           self.enterName.text,
                           self.enterDate.text,
                           self.enterTime.text];
    NSString *docPath =([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]);
    
    NSString *employeeSched=[docPath stringByAppendingPathComponent:@"results.csv"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:employeeSched]) {
        [[NSFileManager defaultManager]
         createFileAtPath:employeeSched contents:nil attributes:nil];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:employeeSched];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[resultLine dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    self.enterName.text=@"";
    self.enterDate.text=@"";
    self.enterTime.text=@"";
}
// Function of the Search Data Button
- (IBAction)searchData:(id)sender {
    NSLog(@"M30FileEditor:searchData Ran! ");

    
    NSString *docPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *employeeSched=[docPath stringByAppendingPathComponent:@"results.csv"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:employeeSched])
        
        resultView.text = employeeSched;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath: employeeSched];
    NSString *dataResults= [[NSString alloc]initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
    [fileHandle closeFile];
    self.resultView.text=dataResults;
}

// Called on startup of File Editor View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"M30FileEditor:viewDidLoad Ran! ");
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"M30FileEditor:didReceiveMemoryWarning Ran! ");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
