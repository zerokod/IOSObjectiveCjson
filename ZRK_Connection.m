//
//  ZRK_Connection.m
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_Connection.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation ZRK_Connection

@synthesize request,completionblock,xmlRootObject;

-(id)initWithRequest:(NSURLRequest *)req
{
    self=[super init];
    if (self) {
        [self setRequest:req];
    }
    return self;
}

-(void) start
{
    container =[[NSMutableData alloc] init];
    
    internalconnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:YES];
    
    if (!sharedConnectionList) {
        sharedConnectionList = [[ NSMutableArray alloc] init];
        
        [sharedConnectionList addObject:self];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [container appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)conn
{
    if ([self xmlRootObject]) {
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:container];
        [parser setDelegate:[self xmlRootObject]];
        [parser parse];
    }
    
    if ([self completionblock]) {
        [self completionblock]([self xmlRootObject],nil);
        
        [sharedConnectionList removeObject:self];
    }
    
}

-(void) connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    if ([self completionblock]) {
        [self completionblock](nil,error);
        
        [sharedConnectionList removeObject:self];
    }
}

@end
