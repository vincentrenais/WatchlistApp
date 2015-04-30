//
//  DiscoverVC.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-29.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "DiscoverVC.h"

@interface DiscoverVC ()

@end

@implementation DiscoverVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Discover";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_discover"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Now Playing", @"Upcoming", @"Popular", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    
    segmentedControl.frame = CGRectMake(25, 80, 325, 30);
    [segmentedControl addTarget:self action:@selector(SegmentControlActions:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    // Do any additional setup after loading the view.
}

-(void)SegmentControlActions:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
        {
            //action for the first button
            [self nowPlaying];
            [[MovieManager sharedList] requestAPI] ;
            break;
        }
        case 1:
        {
            //action for the second button
            [self upcoming];
            break;
        }
        case 2:
        {
            //action for the third button
            [self popular];
            break;
        }
    }
}

-(void)nowPlaying
{
    UITableView *nowPlaying = [[UITableView alloc]initWithFrame:CGRectMake(15, 110, 330, 490)];
    [self.view addSubview:nowPlaying];
}

-(void)upcoming
{
    UITableView *upcoming = [[UITableView alloc]initWithFrame:CGRectMake(15, 110, 330, 490)];
    [self.view addSubview:upcoming];
}

-(void)popular
{
    UITableView *popular = [[UITableView alloc]initWithFrame:CGRectMake(15, 110, 330, 490)];
    [self.view addSubview:popular];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
//    cell.textLabel.text = movie.title;
//    
//    cell.detailTextLabel.text = movie.director;
//    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:19];
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
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
