//
//  StudentDetailViewController.h
//  taller
//
//  Created by HECTOR ALFONSO on 05/10/15.
//  Copyright © 2015 birghtCoders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentDetailViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel *studentName;
@property (nonatomic, weak) IBOutlet UILabel *studentNote;
@property (nonatomic, strong) NSMutableDictionary *dictStudent;

-(IBAction)incrementStudentNote:(id)sender;
@end
