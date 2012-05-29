//
//  XmlAppCtxObjectPropertyHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-24.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectPropertyHandler.h"

@implementation XmlAppCtxObjectPropertyHandler

#pragma mark - Properties

@synthesize name;

#pragma mark - Init/Dealloc

-(void)dealloc {
	name = nil;
}

#pragma mark - Override

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	name = [attributeDict objectForKey:@"name"];
	if (!name) return NO;
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}


@end