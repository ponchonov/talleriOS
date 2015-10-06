//
//  ViewController.m
//  taller
//
//  Created by HECTOR ALFONSO on 05/10/15.
//  Copyright © 2015 birghtCoders. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize arrStudents,tblStudents, indexSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrStudents = @[@{@"name": @"Hector Cuevas", @"score": @"90"},@{@"name": @"Omar Guzmán",@"score": @"80"}, @{@"name": @"Efrain Quintero",@"score": @"80"}, @{@"name": @"Luis Angel Felix",@"score": @"78"},@{@"name": @"Brando Pulido",@"score": @"100"},@{@"name": @"Abel Torres",@"score": @"80"},@{@"name": @"David Magaña",@"score": @"80"},@{@"name": @"Nivaldo Quiñones",@"score": @"89"},@{@"name": @"Aarón Barreto",@"score": @"87"},@{@"name": @"Lucio Morán",@"score": @"78"},@{@"name": @"David Romero",@"score": @"83"}];
    tblStudents.dataSource = self;
    tblStudents.delegate = self;
    [self doCallStudents];
    [tblStudents reloadData];
}

-(void)doCallStudents
{
    [RESTManager sendData:nil toService:@"getStudents" withMethod:@"GET" toCallback:^(id result) {
        NSLog(@"result: %@", result);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrStudents.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CellStudent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary * dictStudent = [arrStudents objectAtIndex:indexPath.row];
    UILabel * lblStudentName = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 250, 40)];
    lblStudentName.text = [dictStudent objectForKey:@"name"];
    UILabel * lblStudentScore = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 250, 40)];
    lblStudentScore.text = [dictStudent objectForKey:@"score"];
    [cell.contentView addSubview:lblStudentName];
    [cell.contentView addSubview:lblStudentScore];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexSelected = indexPath.row;
     [self performSegueWithIdentifier:@"doShowDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    StudentDetailViewController *studentDetailViewController = [segue destinationViewController];;
    studentDetailViewController.dictStudent = [arrStudents objectAtIndex:indexSelected];
}

@end
