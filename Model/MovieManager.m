//
//  MovieManager.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "MovieManager.h"
#import "Movie.h"

@interface MovieManager ()

@property (nonatomic, strong) NSMutableArray *movieList;

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



- (void)deleteMovieFromList:(Movie *)movie
{
    [self.movieList removeObject:movie];
    
    NSMutableArray *arrayOfDictionaries = [[NSMutableArray alloc] init];
    
    for (Movie *movie in self.movieList) {
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
