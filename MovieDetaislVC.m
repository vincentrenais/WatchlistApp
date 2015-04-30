//
//  MovieDetaislVC.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-29.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "MovieDetaislVC.h"

@interface MovieDetaislVC ()

@end

@implementation MovieDetaislVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.APIKey = @"cad549a312eb8c7aa3be5ab77ca14a1f";
//
//    self.requestString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/550?api_key=###
//
//                          
//    http://api.bit.ly/shorten?version=2.0.1&longUrl=%@&login=%@&apiKey=%@&format=json", self.longURL, self.APILogin, self.APIKey];
//    NSURL *requestURL = [NSURL URLWithString:self.requestString];
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    [[session dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//      {
//          //handle errors
//          NSError *e = nil;
//          NSDictionary *bitlyJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
//          
//          if (!error)
//          {
//              NSDictionary *results = [bitlyJSON objectForKey:@"results"];
//              NSDictionary *resultsForLongURL = [results objectForKey:self.longURL];
//              NSString *shortURL = [resultsForLongURL objectForKey:@"shortUrl"];
//              
//              NSLog(@"Short URL = %@",shortURL);
//          }
//          
//          else
//          {
//              //Parse JSON
//              // return JSON value
//              
//          }
//          
//      } ]resume];
//    sleep(60);
//    
//}
    
    
    //LABEL
    
    // Allocates the label and sets its frame
    self.movieTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 100, 350, 44)];
    
    // Sets the text for the label
    self.movieTitleLabel.text = @"Movie";
    
    //Sets the font of the label
    self.movieTitleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:25];
    
    //Adds the label to the view
    [self.view addSubview:self.movieTitleLabel];

    
    //LABEL
    
    // Allocates the label and sets its frame
    self.movieDirectorLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 150, 350, 44)];
    
    // Sets the text for the label
    self.movieDirectorLabel.text = @"Director";
    
    //Sets the font of the label
    self.movieDirectorLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:25];
    
    //Adds the label to the view
    [self.view addSubview:self.movieDirectorLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
