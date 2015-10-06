//
//  ViewController.h
//  taller
//
//  Created by HECTOR ALFONSO on 05/10/15.
//  Copyright © 2015 birghtCoders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentDetailViewController.h"
#import "RESTManager.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tblStudents;
@property (nonatomic, strong) NSArray * arrStudents;
@property (nonatomic, assign) NSInteger indexSelected;
@end

