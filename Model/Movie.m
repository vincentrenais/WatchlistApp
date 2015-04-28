//
//  Movie.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (NSString *)name
{
    return [NSString stringWithFormat:@"%@ %@", self.title, self.director];
}

@end
