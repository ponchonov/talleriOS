//
//  StudentDetailViewController.m
//  taller
//
//  Created by HECTOR ALFONSO on 05/10/15.
//  Copyright © 2015 birghtCoders. All rights reserved.
//

#import "StudentDetailViewController.h"

@interface StudentDetailViewController ()

@end

@implementation StudentDetailViewController
@synthesize studentNote, studentName, dictStudent;
- (void)viewDidLoad {
    [super viewDidLoad];
    studentName.text = [dictStudent objectForKey:@"name"];
    studentNote.text = [dictStudent objectForKey:@"score"];
    // Do any additional setup after loading the view.                                                          }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear: %@", dictStudent);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)incrementStudentNote:(id)sender
{
    if([studentNote.text intValue]<100)
    {
        studentNote.text = [NSString stringWithFormat:@"%d",[studentNote.text intValue]+1];
        if ([studentNote.text intValue]==100)
            ((UIButton *) sender).enabled = NO;
        
    }
}
@end
