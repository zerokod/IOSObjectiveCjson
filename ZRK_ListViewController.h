//
//  ZRK_ListViewController.h
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZRK_RSSChannel;
@class ZRK_WebViewController;

@interface ZRK_ListViewController : UITableViewController <NSXMLParserDelegate, UITableViewDelegate , UITableViewDataSource>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    ZRK_RSSChannel *channel;
}
@property (nonatomic,strong) ZRK_WebViewController *webviewcontroller;

-(void) fetchEntries;

@end
