//
//  ZRK_RSSItem.h
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRK_RSSItem : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property(nonatomic,weak)id parentParserDelegate;

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong) NSString *link;

@end
