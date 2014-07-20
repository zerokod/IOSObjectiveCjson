//
//  ZRK_ListViewController.h
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZRK_RSSChannel;

@interface ZRK_ListViewController : UITableViewController <UITableViewDelegate , UITableViewDataSource>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    ZRK_RSSChannel *channel;
}

-(void) fetchEntries;
@end
