//
//  ZRK_ListViewController.h
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZRK_ListViewController : UITableViewController < UITableViewDelegate , UITableViewDataSource>
{
  
     NSURLConnection *connection;
     NSMutableData *xmlData;
    
     NSMutableData *responseData;
     NSMutableArray * songs;
    
    
     NSMutableArray * artistNameArr;
     NSMutableArray * trackNameArr;
     NSMutableArray * collectionNameArr;
     NSMutableArray * releaseDateArr;
     NSMutableArray * trackPriceArr;
     NSMutableArray * currencyArr;
    
     NSMutableArray * trackViewUrlArr;
     NSMutableArray *previewUrlArr;
     NSMutableArray *previewUrl2Arr;
     NSMutableArray *schemaArr;
     NSMutableArray *artistViewUrlArr;
   
    
    
   
}

@property NSString * artistName;
@property NSString * trackName;
@property NSString * trackViewUrl;
@property NSString * previewUrl;


@property (nonatomic,readonly,strong)NSMutableArray *items;
@property (nonatomic, strong) NSMutableData *responseData;





@end
