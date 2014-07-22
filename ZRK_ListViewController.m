//
//  ZRK_ListViewController.m
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_ListViewController.h"
#import "ZRK_DetailsViewController.h"


@implementation ZRK_ListViewController



@synthesize artistName, trackName,trackViewUrl;

////////////////


@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    self.responseData = [NSMutableData data];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"https://itunes.apple.com/search?term=Michael+jackson"]];
   
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    artistNameArr  = [NSMutableArray arrayWithObjects: nil];
    trackNameArr  = [NSMutableArray arrayWithObjects: nil];
    trackViewUrlArr  = [NSMutableArray arrayWithObjects: nil];
    previewUrlArr  = [NSMutableArray arrayWithObjects: nil];
    previewUrl2Arr  = [NSMutableArray arrayWithObjects: nil];
    schemaArr  = [NSMutableArray arrayWithObjects: nil];
    
    collectionNameArr  = [NSMutableArray arrayWithObjects: nil];
    releaseDateArr  = [NSMutableArray arrayWithObjects: nil];
    trackPriceArr  = [NSMutableArray arrayWithObjects: nil];
    currencyArr  = [NSMutableArray arrayWithObjects: nil];
    artistViewUrlArr  = [NSMutableArray arrayWithObjects: nil];
  
    
  
    
    [self setTitle:@"Michael Jackson"];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    ZRK_ListViewController * tmp;
     tmp = [[ZRK_ListViewController alloc] init];
    
    NSArray *results = [res objectForKey:@"results"];
    
   
    for(NSDictionary *result in results)
    {
  
        
        
        [artistNameArr addObject:[result objectForKey:@"artistName"]];

        [trackNameArr addObject:[result objectForKey:@"trackName"]];
        
        [collectionNameArr addObject:[result objectForKey:@"collectionName"]];
        
        [releaseDateArr addObject:[result objectForKey:@"releaseDate"]];
        
        [trackPriceArr addObject:[NSString stringWithFormat:@"%@", [result objectForKey:@"trackPrice"]]];
        
        [currencyArr addObject:[result objectForKey:@"currency"] ];

        [trackViewUrlArr addObject:[result objectForKey:@"trackViewUrl"]];
        
        [previewUrlArr addObject:[result objectForKey:@"artworkUrl30"] ];
        
        [previewUrl2Arr addObject:[result objectForKey:@"artworkUrl100"]];
        
        [artistViewUrlArr addObject:[result objectForKey:@"artistViewUrl"]];
        

        
        
        
    }
 
    [self.tableView reloadData];
    
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
   
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      
       
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return [trackNameArr  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
   

    [[cell textLabel] setText:[trackNameArr objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [artistNameArr objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[previewUrlArr objectAtIndex:indexPath.row] ]];
        //if (imgData == nil && netStatus == ReachableViaWiFi) {
        if (imgData == nil) {
            NSString *url = [NSString stringWithFormat:@"http://2outgames.com/wp-content/uploads/2014/01/heart-black-trasp.png"];
            imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableViewCell *updateCell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (updateCell) {
                if (imgData) {
                    //[appDelegate setUserPic:contact imgData:imgData];
                    updateCell.imageView.image = [UIImage imageWithData:imgData];
                } else {
                    updateCell.imageView.image = nil;
                }
                //This forces the cell to show image as now
                 //it has normal bounds
                [updateCell setNeedsLayout];
            }
        });
    });
 
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [schemaArr addObject:[artistNameArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[trackNameArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[collectionNameArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[releaseDateArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[trackPriceArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[currencyArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[trackViewUrlArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[previewUrlArr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[previewUrl2Arr objectAtIndex:indexPath.row]];
    
    [schemaArr addObject:[artistViewUrlArr objectAtIndex:indexPath.row]];
    
    
    ZRK_DetailsViewController *dtv = [[ZRK_DetailsViewController alloc] init];

    dtv.songs = schemaArr;
    NSLog(@"array: %@", dtv.songs);
    [[self navigationController] pushViewController:dtv animated:YES];

    
    

}


@end
