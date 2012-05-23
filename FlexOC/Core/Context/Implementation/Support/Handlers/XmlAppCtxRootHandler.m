//
//  XmlAppCtxRootHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxRootHandler.h"

#import "DictionaryApplicationContext.h"
#import "XmlAppCtxObjectsHandler.h"

@implementation XmlAppCtxRootHandler

#pragma mark - Properties

@synthesize context;

#pragma mark - Init/Dealloc

-(void)dealloc {
	context = nil;
}

#pragma mark - Override

-(NSDictionary *) supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectsHandler class], @"objects", 
													  [XmlAppCtxRootHandler class], @"flexoccontext", nil];
}

-(void)willBeginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser withHandler:(id<IXmlApplicationContextParserHandler>)handler {
	if ([handler isKindOfClass:[XmlAppCtxRootHandler class]]) {
		((XmlAppCtxRootHandler*)handler).context = context;
	}
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* strAllowCircularDependencies = [attributeDict objectForKey:@"allowCircularDependencies"];
	if (strAllowCircularDependencies) {
		context.allowCircularDependencies = [strAllowCircularDependencies boolValue];
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(id<IXmlApplicationContextParserHandler>)handler {
	if ([handler isKindOfClass:[XmlAppCtxObjectsHandler class]]) {
		[context.objects addEntriesFromDictionary:((XmlAppCtxObjectsHandler*)handler).objects];		
	}
}

@end