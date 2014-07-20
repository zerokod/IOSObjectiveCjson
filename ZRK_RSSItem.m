//
//  ZRK_RSSItem.m
//  AppCode
//
//  Created by Roberta on 20/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import "ZRK_RSSItem.h"

@implementation ZRK_RSSItem

@synthesize title,link,parentParserDelegate;

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a%@ element",self,elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc]init];
        [self setTitle:currentString];
    }else if([elementName isEqual:@"link"]){
        currentString = [[NSMutableString alloc]init];
        [self setLink:currentString];
    }

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString=nil;
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end
