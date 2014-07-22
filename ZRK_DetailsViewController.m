//
//  ZRK_DetailsViewController.m
//  AppCode
//
//  Created by Roberta on 21/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_DetailsViewController.h"
#import "ZRK_WebViewController.h"


@implementation ZRK_DetailsViewController
@synthesize songs,artistName,trackName,collectionName,releaseDate,trackPrice,currency,immagine;

- (id)init
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self = [super initWithNibName:@"ZRK_DetailsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        NSLog(@"array songs: %@", songs);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[artistName setText:@"dfvsdfv"];
    NSLog(@"array: %@", songs);
    

    
    [self setTitle:[songs objectAtIndex:1]];
    [artistName setText:[songs objectAtIndex:0]];
    [trackName setText:[songs objectAtIndex:1]];
    [collectionName setText:[songs objectAtIndex:2]];
    [releaseDate setText:[songs objectAtIndex:3]];
    [trackPrice setText:[songs objectAtIndex:4]];
    [currency setText:[songs objectAtIndex:5]];
     NSLog(@"detail image 6: %@", [songs objectAtIndex:6]);
    NSLog(@"detail image 7: %@", [songs objectAtIndex:7]);
    NSLog(@"detail image 7: %@", [songs objectAtIndex:8]);
    
    
    NSString *chiaveImmagine = [songs objectAtIndex:8];
    
    if(chiaveImmagine){
    
        
        
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:chiaveImmagine]];
        
        [immagine setImage:[UIImage imageWithData:data]];
        
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:chiaveImmagine]];
            //if (imgData == nil && netStatus == ReachableViaWiFi) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [immagine setImage:[UIImage imageWithData:data]];

                
            });
        });

        
        
    
        
    }
    else {
        
        [immagine setImage:nil];
        
    }

   }

- (IBAction)artistPreview:(id)sender
{
    ZRK_WebViewController *_WebViewController = [[ZRK_WebViewController alloc] init];
    
    [[self navigationController] pushViewController:_WebViewController   animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:[songs objectAtIndex:9]];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[_WebViewController webView]loadRequest:req];
    
    [[_WebViewController navigationItem] setTitle:[songs objectAtIndex:0]];
   
    

}
- (IBAction)trackPreview:(id)sender
{
    ZRK_WebViewController *_WebViewController = [[ZRK_WebViewController alloc] init];
    
    [[self navigationController] pushViewController:_WebViewController   animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:@"http://2outgames.com/"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[_WebViewController webView]loadRequest:req];
    
    [[_WebViewController navigationItem] setTitle:[songs objectAtIndex:1]];
   }

@end
