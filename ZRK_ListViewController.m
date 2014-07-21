//
//  ZRK_ListViewController.m
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_ListViewController.h"
#import "ZRK_RSSChannel.h"
#import "ZRK_WebViewController.h"
#import "ZRK_RSSItem.h"
#import "ZRK_FeedStore.h"

@implementation ZRK_ListViewController

@synthesize webviewcontroller;
@synthesize searchedSong, loadingIcon;
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
    
    self.cachedImages = [[NSMutableDictionary alloc] init];
    self.tableItems = [[NSMutableArray alloc] init];
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
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
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
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    /*
    for (NSDictionary *result in results) {
        NSString *artistName = [result objectForKey:@"artistName"];
        NSString *trackName = [result objectForKey:@"trackName"];
        NSString *trackViewUrl = [result objectForKey:@"trackViewUrl"];
        NSLog(@"icon: %@ %@ %@", artistName,trackName,trackViewUrl);
        
        //Set the parameters
        [tmp setArtistName:artistName];
        [tmp setTrackName:trackName ];
        [tmp setTrackViewUrl:trackViewUrl];
        //Store in array
        [songs addObject:tmp];
        
     
        //Set the parameters
        [tmp setArtistName:[result objectForKey:@"artistName"] ];
        [tmp setTrackName:[result objectForKey:@"trackName"]];
        [tmp setTrackViewUrl:[result objectForKey:@"trackViewUrl"]];
        //Store in array
        [songs addObject:tmp];
        
        

    }
    */
    
    //NSMutableArray *artistNameArr= [[NSMutableArray alloc] init];
    //NSMutableArray *trackNameArr = [[NSMutableArray alloc] init];
    //NSMutableArray *trackViewUrlArr = [[NSMutableArray alloc] init];
    for(NSDictionary *result in results)
    {
        
        artistName = [result objectForKey:@"artistName"];
        trackName = [result objectForKey:@"trackName"];
        trackViewUrl = [result objectForKey:@"trackViewUrl"];
       // previewUrl = [result objectForKey:@"previewUrl"];
        
        //NSLog(@"icon: %@ %@ %@", artistName,trackName,trackViewUrl);
        
        [artistNameArr addObject:artistName];

        [trackNameArr addObject:trackName];

        [trackViewUrlArr addObject:trackViewUrl ];
        
        [previewUrlArr addObject:[result objectForKey:@"artworkUrl30"] ];
        
         NSLog(@"trackName value: %@ \n", [result objectForKey:@"trackName"]);
        
        //[trackNameArr  addObject:trackName ];
    }
    // NSLog(@"prova trackNameArr count = %lu",(unsigned long)[trackNameArr count]);
    //NSLog(@"key: %@, value: %@ \n", key, [dictionary objectForKey:key]);
    //[[self tableView] reloadData];
     NSLog(@"trackNameArr.count: %d", trackNameArr.count);
    [self.tableView reloadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
   
}
////////////////

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //[self fetchEntries];
        //_items = [[NSMutableArray alloc]init];
    }
    return self;
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return 12;
    //return [[channel items]count];
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
   
    //ZRK_ListViewController *item=[[songs ] objectAtIndex:[indexPath row]];
    //[[cell textLabel] setText:[item title]];
   
   
    //ZRK_ListViewController *item=[trackNameArr objectAtIndex:indexPath.row];
    //[[cell textLabel] setText:[item trackName]];
    //[[cell textLabel] setText:@"prova"];
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
    /*

    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[previewUrlArr objectAtIndex:indexPath.row] ]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.accessoryView = [UIImage imageWithData: data];
        });
        
    });
*/
    //NSLog(@"prova= %@",[item trackName]);
   // NSLog(@"prova= %@",[trackNameArr objectAtIndex:indexPath.row]);


    //ZRK_RSSChannel *item=[[channel items] objectAtIndex:[indexPath row]];
    //[[cell textLabel] setText:[item title]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [[self navigationController]pushViewController:webviewcontroller animated:YES];
    
    /*
    ZRK_RSSItem *entry = [[channel items]objectAtIndex:[indexPath row]];
    
    NSURL *url = [NSURL URLWithString:[entry link]];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[webviewcontroller webView]loadRequest:req];
    
    [[webviewcontroller navigationItem] setTitle:[entry title]];
     */
    NSURL *url = [NSURL URLWithString:[trackViewUrlArr objectAtIndex:indexPath.row]];
    
     //NSURL *url = [NSURL URLWithString:@"http://2outgames.com/"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[webviewcontroller webView]loadRequest:req];
    
    [[webviewcontroller navigationItem] setTitle:[trackNameArr objectAtIndex:indexPath.row]];

}

-(void) fetchEntries
{
    
    //NSURL *rssurltofetch=[NSURL URLWithString:@"http://feeds.gawker.com/gizmodo/full"];

    
    
   
    xmlData = [[NSMutableData alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://feeds.gawker.com/gizmodo/full"];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    
    connection= [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    
    
    /*
    [[ZRK_FeedStore sharedStore]fetchRSSFeedWithCompletion:
     ^(ZRK_RSSChannel *obj, NSError *err) {
         
         if (!err) {
             channel=obj;
             [[self tableView] reloadData];
         }else{
             UIAlertView *av =[[UIAlertView alloc]
                               initWithTitle:@"Error" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }
     }];
    
    */
    
    /*
    void( ^completionBlock)(ZRK_RSSChannel *obj,NSError *err)=^(ZRK_RSSChannel *obj, NSError *err){
        
        
        
        if (!err) {
            channel = obj;
            
            [[self tableView] reloadData];
        }else{
            
            NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",[err localizedDescription]];
            
            UIAlertView *av = [[ UIAlertView alloc] initWithTitle:@"Error" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
        }
    };

     [[ZRK_FeedStore sharedStore] fetch:(NSURL *)rssurltofetch withCompletion:completionBlock];
    
    */
}

/*

-(void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)conn
{
    //NSString *xmlCheck = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    //NSLog(@"xmlCheck= %@",xmlCheck);
   
    
    
    NSXMLParser*parser=[[NSXMLParser alloc]initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
    xmlData =nil;
    connection=nil;
    [[self tableView] reloadData];
    NSLog(@"%@\n %@\n %@\n",channel,[channel title],[channel infoString]);
                           
                           
}
-(void) connection:(NSURLConnection *)conn
didFailWithError:(NSError *)error
{
    connection=nil;
    xmlData = nil;
    NSString *errorString = [NSString stringWithFormat:@"ERROR %@",[error localizedDescription]];
    
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}



-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a%@ element",self,elementName);
    
    channel = [[ZRK_RSSChannel alloc]init];
    
    [channel setParentParserDelegate:self];
    
    [parser setDelegate:channel];
}

*/
/*
*
*
* Asynchronous Request Functions
*
*/
/*
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    //Iterate Array and prepare song items
    ZRK_ListViewController * tmp;
   
    
    NSError *e;
    NSArray *object = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&e];
    
#if DEBUG
    NSLog(@"Object: %@", object);
#endif
    
    for (int i=0; i < [object count]; i++) {
        
        tmp = [[ZRK_ListViewController alloc] init];
        
        //Set the parameters
        [tmp setArtist:[[object[i] objectForKey:@"results"] objectForKey:@"name"]];
        //[tmp setTitle:[object[i] objectForKey:@"title"]];
        //[tmp setSnippet:[object[i] objectForKey:@"snippet"]];
        //Store in array
        [songs addObject:tmp];
        
        
    }
    
  
    
    // Turn OFF the loading Icon
    //[loadingIcon stopAnimating];
    
    //Reload View to populate the cells
   [self.tableView reloadData];
    
    
}




- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}
*/
/*
 *
 * Init Functions
 *
 */

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if DEBUG
    NSLog(@"Song inputed: %@", searchedSong);
#endif
    
    
    songs = [[NSMutableArray alloc] init];
    
    searchedSong = [searchedSong stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    // Turn on the loading Icon
    //[loadingIcon startAnimating];
    
    // Prepare URL and Request
    //NSURL * url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"http://api.lyricsnmusic.com/songs?api_key=05d//835b0b3e2b143c00c3751db691c&track=%@", searchedSong]];
    
    
     NSURL * url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=Michael+jackson"]];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    // Make asynchronous request
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    NSLog(@"%@", conn);
    
    
    
 
    

}
 */

@end
