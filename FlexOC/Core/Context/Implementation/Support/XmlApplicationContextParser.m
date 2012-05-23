//
//  XmlApplicationContextParser.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlApplicationContextParser.h"

#import "DictionaryApplicationContext.h"
#import "XmlAppCtxRootHandler.h"
#import "XmlApplicationContext.h"

@interface XmlApplicationContextParser (Private)

-(XmlAppCtxRootHandler*) parseWithXMLFilepath:(NSString*) path andSetAppContext:(XmlApplicationContext*) appContext;
-(XmlAppCtxRootHandler*) parseWithXMLURL:(NSURL*) url andSetAppContext:(XmlApplicationContext*) appContext;

@end

@implementation XmlApplicationContextParser

#pragma mark - Public methods

+(BOOL) ParseWithXMLFilepath:(NSString*) path andSetAppContext:(XmlApplicationContext*) appContext {
	XmlApplicationContextParser* parser = [[[self class] alloc] init];
	XmlAppCtxRootHandler* handler = [parser parseWithXMLFilepath:path andSetAppContext:appContext];
	
	return (handler != nil);
}

+(BOOL)ParseWithXMLURL:(NSURL *)url andSetAppContext:(XmlApplicationContext*) appContext {
	XmlApplicationContextParser* parser = [[[self class] alloc] init];
	XmlAppCtxRootHandler* handler = [parser parseWithXMLURL:url andSetAppContext:appContext];

	return (handler != nil);
}

@end

@implementation XmlApplicationContextParser (Private)

-(XmlAppCtxRootHandler*) parseWithXMLFilepath:(NSString*) path andSetAppContext:(XmlApplicationContext*) appContext {
	
	NSString* currentDirectory = [[NSFileManager defaultManager] currentDirectoryPath];
	[[NSFileManager defaultManager] changeCurrentDirectoryPath:[path stringByDeletingLastPathComponent]];
	
	XmlAppCtxRootHandler* handler = [self parseWithXMLURL:[NSURL fileURLWithPath:path] andSetAppContext:appContext];
	
	[[NSFileManager defaultManager] changeCurrentDirectoryPath:currentDirectory];
	
	return handler;
}

-(XmlAppCtxRootHandler*) parseWithXMLURL:(NSURL *)url andSetAppContext:(XmlApplicationContext*) appContext {
	XmlAppCtxRootHandler* handler = [[XmlAppCtxRootHandler alloc] init];
	handler.context = appContext;
	
	NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	parser.delegate = handler;
	[parser parse];
	
	if ([parser parserError]) 
		return nil;
	
	return handler;
}

@end
