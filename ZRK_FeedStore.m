//
//  ZRK_FeedStore.m
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_FeedStore.h"
#import "ZRK_Connection.h"
#import "ZRK_RSSChannel.h"
#import "ZRK_RSSItem.h"

@implementation ZRK_FeedStore

+(ZRK_FeedStore *)sharedStore
{
    static ZRK_FeedStore *feedStore = nil;
    if (!feedStore) {
        feedStore=[[ZRK_FeedStore alloc]init];
    }
    return feedStore;
}

/*
-(void)fetchRSSFeedWithCompletion:(void (^)(ZRK_RSSChannel *obj,NSError *err))block
{
    NSURL *url=[NSURL URLWithString:@"http://feeds.gawker.com/gizmodo/full"];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    
    ZRK_RSSChannel *channel=[[ZRK_RSSChannel alloc]init];
    
    ZRK_Connection *connection= [[ZRK_Connection alloc]initWithRequest:req];
    
    [connection setCompletionblock:block];
    
    [connection setXmlRootObject:channel];
    
    [connection start];
    
    

}*/


- (void) fetchRSSFeedWithCompletion:(void (^)(ZRK_RSSChannel *, NSError *))block
//- (ZRK_RSSChannel *)fetchRSSFeedWithCompletion:(NSURL *)rssurltofetch:(void (^)(ZRK_RSSChannel *obj, NSError *err))block
{
    /*
     NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
     cachePath = [cachePath stringByAppendingPathComponent:@"apple.archive"];
     
     NSDate *tscDate = [self CacheDate];
     if (tscDate) {
     NSTimeInterval cacheAge = [tscDate timeIntervalSinceNow];
     if (cacheAge> -300.0) {
     NSLog(@"Reading cache");
     ZRK_RSSChannel *cachedchannel = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
     if (cachedchannel) {
     block(cachedchannel,nil);
     return;
     }
     }
     }
     */
    
    //NSURL *url = [NSURL URLWithString:@"http://www.2outgames.com/advancedfeed/rsslist.xml"];
    
    //NSURLRequest *req = [NSURLRequest requestWithURL:rssurltofetch];
    
    NSURL *url=[NSURL URLWithString:@"http://feeds.gawker.com/gizmodo/full"];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    
    ZRK_RSSChannel *channel = [[ZRK_RSSChannel alloc] init];
    ZRK_Connection *connection = [[ZRK_Connection alloc] initWithRequest:req];
    
    //[connection setCompletionBlock:block];
    
    
    
    [connection setCompletionblock:block];
    
   
    
    
    /*
     [connection setCompletionBlock:^(ZRK_RSSChannel *obj, NSError *err) {
     
     if (!err) {
     [self setCacheDate:[NSDate date]];
     [NSKeyedArchiver archiveRootObject:obj toFile:cachePath];
     }
     block(obj,err);
     }];
     */
    [connection setXmlRootObject:channel];
    [connection start];
    
    //return cachedChannel;
    
    
}
///////////////

///////////////

- (void)fetch:(NSURL *)rssurltofetch
withCompletion :(void (^)(ZRK_RSSChannel *, NSError *))block
{
    
    //NSString *requestString = [NSString stringWithFormat:@"http://www.apple.com/pr/feeds/pr.rss"];
    //NSString *requestString = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/topsongs/limit=%d/xml",count];
    // NSURL *url = [NSURL URLWithString:requestString];
    //NSURL *url = [NSURL URLWithString:rssurltofetch];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:rssurltofetch];
    ZRK_RSSChannel *channel = [[ZRK_RSSChannel alloc]init];
    
    ZRK_Connection *connection = [[ZRK_Connection alloc]initWithRequest:req];
    [connection setCompletionblock:block];
    [connection setXmlRootObject:channel];
    [connection start];
}


/////////////


@end
