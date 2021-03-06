//
//  AddMovieVC.h
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieManager.h"

@interface AddMovieVC : UIViewController <UITextFieldDelegate>

@property(strong,nonatomic) UITextField *movieTitleTF;
@property(strong,nonatomic) UITextField *movieDirectorTF;
@property(strong,nonatomic) UITextView *confirmationTV;

@end
