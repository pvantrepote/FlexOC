//
//  XmlApplicationContextParser.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlApplicationContextParser.h"

#import "DictionaryApplicationContext.h"
#import "XmlAppCtxHandlerBase.h"

@implementation XmlApplicationContextParser

#pragma mark - Properties

@synthesize configuration;

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		configuration = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)dealloc {
	configuration = nil;
	context = nil;	
}

#pragma mark - Public methods

+(NSDictionary*) ParseWithXMLFilepath:(NSString*) path {
	XmlApplicationContextParser* parser = [[[self class] alloc] init];
	if ([parser parseWithXMLFilepath:path]) {
		return parser.configuration;
	}
	
	return nil;
}

+(NSDictionary *)ParseWithXMLURL:(NSURL *)url {
	XmlApplicationContextParser* parser = [[[self class] alloc] init];
	if ([parser parseWithXMLURL:url]) {
		return parser.configuration;
	}
	
	return nil;
}

-(BOOL) parseWithXMLFilepath:(NSString*) path {
	return [self parseWithXMLURL:[NSURL fileURLWithPath:path]];
}

-(BOOL)parseWithXMLURL:(NSURL *)url {
	XmlAppCtxHandlerBase* handler = [[XmlAppCtxHandlerBase alloc] init];
	handler.context = configuration;
	
	NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	parser.delegate = handler;
	[parser parse];
	
	return ([parser parserError] == nil);
}

@end
