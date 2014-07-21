//
//  ZRK_Connection.h
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRK_Connection : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

{
    NSURLConnection *internalconnection;
    NSMutableData *container;
}

-(id) initWithRequest:(NSURLRequest *)req;

@property (nonatomic,copy) NSURLRequest *request;
@property (nonatomic,copy)void (^completionblock)(id obj,NSError *err);
@property (nonatomic,copy) id <NSXMLParserDelegate> xmlRootObject;

-(void)start;

@end
