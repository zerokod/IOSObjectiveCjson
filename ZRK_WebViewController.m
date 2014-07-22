//
//  ZRK_WebViewController.m
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_WebViewController.h"

@implementation ZRK_WebViewController

-(void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen]applicationFrame];
    UIWebView *wv=[[UIWebView alloc]initWithFrame:screenFrame];
    [wv setScalesPageToFit:YES];
    [self setView:wv];
}

-(UIWebView *)webView
{
    return (UIWebView *)[self view];
}


@end
