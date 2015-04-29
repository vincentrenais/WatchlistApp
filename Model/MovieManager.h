//
//  MovieManager.h
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Movie;
@interface MovieManager : NSObject


@property (strong,nonatomic) NSString *api_key;
@property (strong,nonatomic) NSString *request_token;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *password;

@property (strong,nonatomic) NSString *requestString;

+ (instancetype)sharedList;

- (void)addMovieToList:(Movie *)movie;

- (void)deleteMovieFromList:(Movie *)movie;

- (NSArray *)getMovieList;


@end
