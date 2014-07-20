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

@implementation ZRK_ListViewController

@synthesize webviewcontroller;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self fetchEntries];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

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
    //return 0;
    return [[channel items]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    ZRK_RSSChannel *item=[[channel items] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[item title]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self navigationController]pushViewController:webviewcontroller animated:YES];
    
    ZRK_RSSItem *entry = [[channel items]objectAtIndex:[indexPath row]];
    
    NSURL *url = [NSURL URLWithString:[entry link]];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[webviewcontroller webView]loadRequest:req];
    
    [[webviewcontroller navigationItem] setTitle:[entry title]];
}

-(void) fetchEntries
{
    xmlData = [[NSMutableData alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://feeds.gawker.com/gizmodo/full"];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    
    connection= [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}
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




@end
