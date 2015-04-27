//
//  IMDBWebVC.h
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMDBWebView : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *IMDBWebView;

@end
