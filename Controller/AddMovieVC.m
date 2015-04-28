//
//  AddMovieVC.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "AddMovieVC.h"
#import "Movie.h"
@interface AddMovieVC ()


@end

@implementation AddMovieVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Add a movie";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_addMovie"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //LABEL
    
    // Allocates the label and sets its frame
    UILabel *addMovieLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 100, 350, 44)];
    
    // Sets the text for the label
    addMovieLabel.text = @"Add a movie to the watchlist!";
    
    //Sets the font of the label
    addMovieLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:25];
    
    //Adds the label to the view
    [self.view addSubview:addMovieLabel];
    
    
    //TEXTFIELD FOR TITLE
    
    // Allocates the textfield and sets its frame
    self.movieTitleTF = [[UITextField  alloc] initWithFrame:
                         CGRectMake(25, 170, 315, 40)];
    
    // Sets the border style of the text field
    self.movieTitleTF.borderStyle = UITextBorderStyleRoundedRect;
    
    // Sets the font
    [self.movieTitleTF setFont:[UIFont fontWithName:@"Helvetica-Light" size:24]];
    
    // Placeholder text is displayed when no text is typed
    self.movieTitleTF.placeholder = @"Title";
    
    // Adds the textField to the view
    [self.view addSubview:self.movieTitleTF];
    
    // Replace Return with Done
    self.movieTitleTF.returnKeyType = UIReturnKeyDone;
    
    
    //TEXTFIELD FOR DIRECTOR
    
    // Allocates the textfield and sets its frame
    self.movieDirectorTF = [[UITextField  alloc] initWithFrame:
                            CGRectMake(25, 230, 315, 40)];
    
    // Sets the border style of the text field
    self.movieDirectorTF.borderStyle = UITextBorderStyleRoundedRect;
    
    // Sets the font
    [self.movieDirectorTF setFont:[UIFont fontWithName:@"Helvetica-Light" size:24]];
    
    // Placeholder text is displayed when no text is typed
    self.movieDirectorTF.placeholder = @"Director";
    
    // Adds the textField to the view
    [self.view addSubview:self.movieDirectorTF];
    
    // Replace Return with Done
    self.movieDirectorTF.returnKeyType = UIReturnKeyDone;
    
    self.movieTitleTF.delegate = self;
    self.movieDirectorTF.delegate = self;
    
    //BUTTON
    
    // Allocates the button
    UIButton *addMovieButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    // Sets the button's frame
    addMovieButton.frame = CGRectMake(80, 320, 200, 44);
    
    // Sets the button's font
    addMovieButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:20];
    
    // Sets button's text
    [addMovieButton setTitle:@"Add this movie" forState:UIControlStateNormal];
    
    // Adds the button to the view
    [self.view addSubview:addMovieButton];
    
    // Sets actions when button is tapped
    [addMovieButton addTarget:self action:@selector(addMovie) forControlEvents:UIControlEventTouchUpInside];
    
    [addMovieButton addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents: UIControlEventTouchUpInside];
    
}

// This method is called once we tap inside the textField

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}

// This method is called once we complete editing

-(void)textFieldDidEndEditing:(UITextField *)textField
{

}

// This method is called once we touch outside of the textfield

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.movieTitleTF isFirstResponder] && [touch view] != self.movieTitleTF)
    {
        [self.movieTitleTF resignFirstResponder];
        
    }if ([self.movieDirectorTF isFirstResponder] && [touch view] != self.movieTitleTF) {
        [self.movieDirectorTF resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

// This method is called once we hit return on the keyboard

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [self.movieTitleTF resignFirstResponder];
    [self.movieDirectorTF resignFirstResponder];
    
    return YES;
}

// This method adds a movie to the watchlist

- (void)addMovie
{
    
    NSString *newMovieTitle = self.movieTitleTF.text;
    NSString *newMovieDirector = self.movieDirectorTF.text;
    Movie *movie = [[Movie alloc] init];
    movie.title = newMovieTitle;
    movie.director = newMovieDirector;
    if ([movie.title  isEqualToString: @""])
    {
        self.movieTitleTF.placeholder = @"You need a Title!!!";
    }
    else
    {
        [[MovieManager sharedList] addMovieToList:movie];
        
        self.movieTitleTF.placeholder = @"Title";
        self.movieTitleTF.text = @"";
        [self.movieTitleTF resignFirstResponder];
        
        self.movieDirectorTF.placeholder = @"Director";
        self.movieDirectorTF.text = @"";
        [self.movieDirectorTF resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
