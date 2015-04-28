//
//  WatchlistTVC.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "WatchlistTVC.h"
#import "IMDBWebVC.h"
#import "Movie.h"

@interface WatchlistTVC ()

@property (nonatomic, strong) NSArray *movieList;

@end


@implementation WatchlistTVC
{
    UISearchController *searchController;
    NSArray *movies;
    NSArray *searchResults;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Watchlist";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_toWatch"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.movieList = [[MovieManager sharedList] getMovieList];
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
}

- (void)filterContentForSearchText:(NSString *)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    searchResults = [movies filteredArrayUsingPredicate:resultPredicate];
}

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self filterContentForSearchText:searchController.searchBar.text];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    if (searchController.active) {
        return searchResults.count;
    } else
    {
        return  self.movieList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Movie *movie;
    
    if (searchController.active) {
        movie
    }
    
    = self.movieList[indexPath.row];
    
    
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text = movie.director;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:19];
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IMDBWebView *webView = [[IMDBWebView alloc]init];
    
    [self.navigationController pushViewController:webView animated:YES];
    
    NSString *cellTitleText = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    [[NSUserDefaults standardUserDefaults] setObject:cellTitleText forKey:@"clickedMovie"];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [[MovieManager sharedList] deleteMovieFromList:self.movieList[indexPath.row]];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
