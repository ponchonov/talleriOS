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
@synthesize arrStudents,tblStudents, indexSelected,gMap,locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    tblStudents.dataSource = self;
    tblStudents.delegate = self;
    gMap.settings.myLocationButton =YES;
    gMap.delegate=self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [locationManager requestWhenInUseAuthorization];
    dispatch_async(dispatch_get_main_queue(), ^{
        [locationManager startUpdatingLocation];
    });
    [self doCallStudents];
}
#pragma mark -- CLLocationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations objectAtIndex:0];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude
                                                            longitude:currentLocation.coordinate.longitude                                                                         zoom:16];
    dispatch_async(dispatch_get_main_queue(), ^{
        [gMap animateToCameraPosition:camera];
    });
}

-(void)doCallStudents
{
    [RESTManager sendData:nil toService:@"getStudents" withMethod:@"GET" toCallback:^(id result) {
        NSLog(@"result: %@", result);
        arrStudents = [NSArray arrayWithArray:[result objectForKey:@"students"]];
        [tblStudents reloadData];
    }];
}
#pragma mark tableView Delegate
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
