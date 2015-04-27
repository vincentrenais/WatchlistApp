//
//  IMDBWebVC.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "IMDBWebVC.h"

@implementation IMDBWebView

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Movie details";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.IMDBWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    
    [self.view addSubview:self.IMDBWebView];
    
    NSString *cellTitleText = [[NSUserDefaults standardUserDefaults] objectForKey:@"clickedMovie"];
    
    NSString *url = [NSString stringWithFormat:@"http://m.imdb.com/find?ref_=nv_sr_fn&q=%@&s=all", cellTitleText];
    
    NSString* urlNonAscii = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.IMDBWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlNonAscii]]];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
