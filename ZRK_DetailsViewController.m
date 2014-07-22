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
    // Do any additional setup after loading the view from its nib.
    //[super viewWillAppear:animated];
    //songs = [NSMutableArray arrayWithObjects: nil];
    //songs2  = [NSMutableArray arrayWithObjects: nil];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(id) initPerNuovoElemento:(NSMutableArray*)fillarr;{
    
    self = [super initWithNibName:@"ZRK_DetailsViewController" bundle:nil];
    if(self){
        if(fillarr){
            
           [songs addObject:[fillarr objectAtIndex:0]];
            NSLog(@"fillarr : %@", [fillarr objectAtIndex:0]);
            NSLog(@"fillarr count: %d", [fillarr count]);
           NSLog(@"songs count: %d", [songs count]);
            for (id obj in fillarr)
                NSLog(@"fillarr obj: %@", obj);
            
            NSLog(@"array: %@", songs);
             [artistName setText:@"gfbgb"];
            //[artistName setText:[fillarr objectAtIndex:0]];
             [trackName setText:[fillarr objectAtIndex:1]];
            [collectionName setText:[fillarr objectAtIndex:2]];

            UIBarButtonItem *oggettoCreato = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:oggettoCreato];
            UIBarButtonItem *cancellaOggetto = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem]setLeftBarButtonItem:cancellaOggetto];
            
        }
        
    }
    return self;
}
*/
/*
-(void)fillScheda:(NSMutableArray*)fillarr
{
    //[songs addObject:[fillarr objectAtIndex:0]];
    NSLog(@"fillarr count: %d", [fillarr count]);
    NSLog(@"fillarr count: %@", fillarr);
    [songs addObject:fillarr];
    NSLog(@"songs count: %d", [songs count]);
    NSLog(@"songs 1: %@", [songs objectAtIndex:0]);
    [songs2 addObject:[songs objectAtIndex:0]];
    for (id obj in songs2)
        NSLog(@"songs2 obj: %@", obj);
    //[self setTitle:[fillarr objectAtIndex:0]];
    // songs=fillarr;
   //[artistName setText:[fillarr objectAtIndex:0]];
   // [trackName setText:[fillarr objectAtIndex:1]];
   //[collectionName setText:[fillarr objectAtIndex:2]];
    
}*/

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[artistName setText:@"dfvsdfv"];
    NSLog(@"array: %@", songs);
    //[trackName setText:[songs objectAtIndex:1]];
    //[collectionName setText:[fillarr objectAtIndex:2]];

    
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
    
        //[immagine setImage:immagineDaVisualizzare];
        
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:chiaveImmagine]];
        
        [immagine setImage:[UIImage imageWithData:data]];
        
        /////////////////
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:chiaveImmagine]];
            //if (imgData == nil && netStatus == ReachableViaWiFi) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [immagine setImage:[UIImage imageWithData:data]];

                
            });
        });

        
        
        
        ///////////////////
        
    }
    else {
        
        [immagine setImage:nil];
        
    }

    /*
    [nome setText:[oggetto nomeOggetto]];
    [seriale setText:[oggetto numeroDiSerie]];
    [valore setText:[NSString stringWithFormat:@"%d", [oggetto valore]]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    [data setText:[df stringFromDate:[oggetto dataCreazione]]];
    NSString *chiaveImmagine = [oggetto chiaveImmagine];
    
    if(chiaveImmagine){
        
        UIImage *immagineDaVisualizzare =[[MagazzinoImmagini magazzinoCondiviso] ottieniImmagineDaChiave:chiaveImmagine];
        [immagine setImage:immagineDaVisualizzare];
        
    }
    else {
        
        [immagine setImage:nil];
        
    }
    */
}

- (IBAction)artistPreview:(id)sender
{
    ZRK_WebViewController *_WebViewController = [[ZRK_WebViewController alloc] init];
    
    [[self navigationController] pushViewController:_WebViewController   animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:[songs objectAtIndex:9]];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[_WebViewController webView]loadRequest:req];
    
    [[_WebViewController navigationItem] setTitle:[songs objectAtIndex:0]];
    /*
    
    [[self navigationController]pushViewController:webviewcontroller animated:YES];
    
    //NSURL *url = [NSURL URLWithString:[trackViewUrlArr objectAtIndex:indexPath.row]];
    
    NSURL *url = [NSURL URLWithString:@"http://2outgames.com/"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[webviewcontroller webView]loadRequest:req];
    
    [[webviewcontroller navigationItem] setTitle:[songs objectAtIndex:0]];
    
   */
    ///////////////////////
    

}
- (IBAction)trackPreview:(id)sender
{
    ZRK_WebViewController *_WebViewController = [[ZRK_WebViewController alloc] init];
    
    [[self navigationController] pushViewController:_WebViewController   animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:@"http://2outgames.com/"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[_WebViewController webView]loadRequest:req];
    
    [[_WebViewController navigationItem] setTitle:[songs objectAtIndex:1]];
    /////////
    
    //[[self navigationController] pushViewController:ZRK_WebViewController   animated:YES];
   /*
    [[self navigationController]pushViewController:webviewcontroller animated:YES];
    
    //NSURL *url = [NSURL URLWithString:[trackViewUrlArr objectAtIndex:indexPath.row]];
    
    NSURL *url = [NSURL URLWithString:@"http://2outgames.com/"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[webviewcontroller webView]loadRequest:req];

    [[webviewcontroller navigationItem] setTitle:[songs objectAtIndex:1]];*/
    
    /////////////////
}

@end
