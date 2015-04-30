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

+ (instancetype)sharedList;

- (void)addMovieToList:(Movie *)movie;

- (void)deleteMovieFromList:(Movie *)movie;

- (NSArray *)getMovieList;

-(void)requestAPIWithOption:(NSInteger)option success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

@end
