//
//  XmlAppCtxResourcesHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxResourcesHandler.h"

#import "ApplicationContextResourceProvider.h"
#import "IApplicationContext.h"

@implementation XmlAppCtxResourcesHandler

#pragma mark - Properties

@synthesize includes;

#pragma mark - Init/Dealloc

-(id)init {
	self = [super init];
	if (self) {
		includes = [NSMutableArray array];
	}
	
	return self;
}

-(void)dealloc {
	includes = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxRcsIncludeHandler class], @"include", nil];
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(XmlAppCtxRcsIncludeHandler*)handler {
	if (!handler.context) return;
	
	[includes addObject:handler.context];
}

@end

@implementation XmlAppCtxRcsIncludeHandler

#pragma mark - Properties

@synthesize context;

#pragma mark - Init/Dealloc

-(void)dealloc {
	context = nil;
}

#pragma mark - Override

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	NSString* toInclude = [attributeDict objectForKey:@"name"];
	if (!toInclude) {
		return NO;
	}
	
	NSString* pathToResource = [ApplicationContextResourceProvider resolveFilepath:toInclude];
	if (!pathToResource) {
		return NO;
	}
	
	context = [IApplicationContext ApplicationContextFromLocation:pathToResource];
	if (!context) {
		return NO;
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

@end