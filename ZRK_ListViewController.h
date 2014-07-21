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

@interface ZRK_ListViewController : UITableViewController < UITableViewDelegate , UITableViewDataSource>
{
  
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    NSMutableData *responseData;
    NSMutableArray * songs;
    ZRK_RSSChannel *channel;
    
     NSMutableArray * artistNameArr;
     NSMutableArray * trackNameArr;
     NSMutableArray * trackViewUrlArr;
    NSMutableArray *previewUrlArr;
}
@property (nonatomic,strong) ZRK_WebViewController *webviewcontroller;
@property NSString * artistName;
@property NSString * trackName;
@property NSString * trackViewUrl;
@property NSString * previewUrl;

@property NSString * searchedSong;
@property NSString * loadingIcon;
@property (nonatomic,readonly,strong)NSMutableArray *items;
@property (nonatomic, strong) NSMutableData *responseData;

@property (strong ,nonatomic) NSMutableArray *tableItems;
@property (strong ,nonatomic) NSMutableDictionary *cachedImages;


-(void) fetchEntries;

@end
