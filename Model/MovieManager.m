//
//  MovieManager.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "MovieManager.h"
#import "Movie.h"

#define BASE_URL @"http://api.themoviedb.org/3"
#define URL(path) [NSString stringWithFormat:@"%@%@",BASE_URL, path]
#define API_key @"cad549a312eb8c7aa3be5ab77ca14a1f"

@interface MovieManager ()

@property (strong, nonatomic) NSMutableArray *movieList;
@property (strong, nonatomic) NSMutableArray *listOfTitles;

@end

@implementation MovieManager

- (instancetype)init
{
    
    self = [super init];
    if (self)
    {
        self.movieList = [[NSMutableArray alloc] init];
        
    }
    return self;
}


+ (instancetype)sharedList
{
    static MovieManager *movieList = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        movieList = [[MovieManager alloc] init];
        NSArray *listOfDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"movieList"];
        [movieList.movieList addObjectsFromArray:[movieList getMovieObjectFromListOfDicts:listOfDict]];
    });
    return movieList;
}

- (void)addMovieToList:(Movie *)movie
{
    [self.movieList addObject:movie];
    NSDictionary *movieDict = @{ @"title" : movie.title,
                                 @"director" :movie.director};
    NSArray *oldList = [[NSUserDefaults standardUserDefaults] objectForKey:@"movieList"];
    if (oldList)
    {
        NSMutableArray *newList = [NSMutableArray arrayWithArray:oldList];
        [newList addObject:movieDict];
        [[NSUserDefaults standardUserDefaults] setObject:newList forKey:@"movieList"];
    }
    else
    {
        NSMutableArray *newList = [[NSMutableArray alloc] initWithObjects:movieDict, nil];
        [[NSUserDefaults standardUserDefaults] setObject:newList forKey:@"movieList"];
    }
}

-(void)requestAPIWithOption:(NSInteger)option success:(void (^)(NSMutableArray *array))success failure:(void (^)(NSError *error))failure
{
     //Do any additional setup after loading the view.
    NSString *requestUrlString = nil;
    switch (option)
    {
        case 0:
            requestUrlString = URL(@"/movie/now_playing");
            break;
        case 1:
            requestUrlString = URL(@"/movie/upcoming");
            break;
        case 2:
            requestUrlString = URL(@"/movie/popular");
            break;
            
        default:
            NSLog(@"No URL!");
            break;
    }
    

    
    
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?api_key=%@",requestUrlString, API_key]];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    [request setHTTPMethod:@"GET"];
//    
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                            completionHandler:
//                                  ^(NSData *data, NSURLResponse *response, NSError *error)
//    {
//                                      
//                                      if (error) {
//                                          // Handle error...
//                                          return;
//                                      }
//        
//                                      NSError *e = nil;
//                                      NSDictionary *movieJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
//
//                                      if ([response isKindOfClass:[NSHTTPURLResponse class]])
//                                      {
//                                          
//                                          NSArray *results = [movieJSON objectForKey:@"results"];
//                                          self.listOfTitles = [[NSMutableArray alloc]init];
//                                          
//                                          for (NSDictionary *dicts in results)
//                                          {
//                                              
//                                              [self.listOfTitles addObject:[dicts objectForKey:@"title"]];
//                                          }
//                                          if (success)
//                                          {
//                                              success(self.listOfTitles);
//                                              
//                                              return;
//                                          }
//                                      }
//                                      else
//                                      {
//                                          failure(e);
//                                          return;
//                                      }
//        
//    }];
//    
//    [task resume];
//}

    



NSString *URLwithKey = [NSString stringWithFormat:@"%@?api_key=%@",requestUrlString, API_key];

NSURL *requestURL = [NSURL URLWithString:URLwithKey];

NSURLSession *session = [NSURLSession sharedSession];

[[session dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
  {
      //handle errors
      NSError *e = nil;
      NSDictionary *movieJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
      
      if (!error)
      {
          NSArray *results = [movieJSON objectForKey:@"results"];
          
          self.listOfTitles = [[NSMutableArray alloc]init];
          
          for (NSDictionary *dicts in results){
              
              [self.listOfTitles addObject:[dicts objectForKey:@"title"]];
              
          }
          
          if (success)
          {
              dispatch_sync(dispatch_get_main_queue(), ^{
                  success(self.listOfTitles);
              });
              
              return;
          }
      }
      else
      {
          if (failure)
          {
              dispatch_sync(dispatch_get_main_queue(), ^{
                  success(self.listOfTitles);
              });
          }
          failure(e);
          return;
      }
  }
  ]resume];
}



- (void)deleteMovieFromList:(Movie *)movie
{
    [self.movieList removeObject:movie];
    
    NSMutableArray *arrayOfDictionaries = [[NSMutableArray alloc] init];
    
    for (Movie *movie in self.movieList)
    {
        NSDictionary *movieDict = @{ @"title" : movie.title,
                                     @"director" :movie.director};
        
        [arrayOfDictionaries addObject:movieDict];
        
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfDictionaries forKey:@"movieList"];
    }

}


- (NSArray *)getMovieObjectFromListOfDicts:(NSArray *)listOfDicts
{
    NSMutableArray *arrayOfMovie = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in listOfDicts)
    {
        Movie *movie = [[Movie alloc] init];
        movie.title = dict[@"title"];
        movie.director = dict[@"director"];
        [arrayOfMovie addObject:movie];
    }
    return arrayOfMovie;
}

- (NSArray *)getMovieList
{
    return self.movieList;
}



@end
