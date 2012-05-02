//
//  XmlAppCtxContainerEntryHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxContainerEntryHandler.h"

#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxDictionayHandler.h"
#import "XmlAppCtxListHandler.h"
#import "DictionaryApplicationContext.h"

@implementation XmlAppCtxContainerEntryHandler

#pragma mark - Properties

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", 
													  nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	BOOL needaKey = [super.parent isKindOfClass:[XmlAppCtxDictionayHandler class]];
	NSString* value = [attributeDict objectForKey:@"value"];
	NSString* ref = nil;
	if (!value) ref = [attributeDict objectForKey:@"ref"];
	
	if (needaKey) {
		NSString* key = [attributeDict objectForKey:@"key"];
		if (!key) {
			return NO;
		}
		
		if (value || ref) {
			if (ref || [value hasPrefix:@"%@"]) {
				value = [NSString stringWithFormat:@"@%@", (ref) ? ref : value];
			}
			
			[self.context setObject:value 
							 forKey:key];
		}
		else {
			[self pushNewContextForKey:key];
		}
	}
	else {
		XmlAppCtxListHandler* listHandler = self.parent;
		if (value || ref) {
			if (ref || [value hasPrefix:@"%@"]) {
				value = [NSString stringWithFormat:@"@%@", (ref) ? ref : value];
			}
			
			[listHandler.list addObject:value];
		}
		else {
			[listHandler.list addObject:[NSMutableDictionary dictionary]];
			self.context = [listHandler.list lastObject];
		}
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

@end
