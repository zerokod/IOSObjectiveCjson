//
//  ZRK_FeedStore.h
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZRK_RSSChannel;
@class ZRK_RSSItem;

@interface ZRK_FeedStore : NSObject

+(ZRK_FeedStore *)sharedStore;

-(void)fetchRSSFeedWithCompletion:(void (^)(ZRK_RSSChannel *obj,NSError *err))block;


- (void) fetch:(NSURL *)rssurltofetch
withCompletion:(void (^)(ZRK_RSSChannel *obj, NSError *err))block;

@end
