
//
//  DiscoverVC.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-29.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "DiscoverVC.h"

@interface DiscoverVC ()

@property (strong,nonatomic) UITableView *tableView;


@end

@implementation DiscoverVC
{
    NSArray *_finalList;
}


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
    
    segmentedControl.frame = CGRectMake(25, 85, 325, 30);
    [segmentedControl addTarget:self action:@selector(SegmentControlActions:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 125, 330, 490)];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self listOfMovies:0];
}

-(void)SegmentControlActions:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
        {
            [self listOfMovies:0];
            break;
        }
        case 1:
        {
            [self listOfMovies:1];
            break;
        }
        case 2:
        {
            [self listOfMovies:2];
            break;
        }
    }
}

-(void)listOfMovies:(NSInteger)option
{
    __weak typeof(self) weakSelf = self;
    [[MovieManager sharedList] requestAPIWithOption:option success:^(NSMutableArray *array)
     {
         _finalList = array;
         
         [weakSelf.tableView reloadData];
         
         NSLog(@"%@",_finalList);
         
     } failure:^(NSError *error)
     {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"alert" message:@"It didn't work!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
         [alert show];
     }];
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
    return _finalList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tempDict = [_finalList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempDict objectForKey:@"title"];
    
    cell.detailTextLabel.text = [tempDict objectForKey:@"posterPath"];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:19];

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
