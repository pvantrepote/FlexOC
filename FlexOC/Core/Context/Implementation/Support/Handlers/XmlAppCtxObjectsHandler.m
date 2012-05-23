//
//  XmlAppCtxObjectsHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectsHandler.h"

#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxDictionayHandler.h"
#import "XmlAppCtxListHandler.h"

#import "DictionaryApplicationContext.h"
#import "IObjectDefinition.h"

@implementation XmlAppCtxObjectsHandler

#pragma mark - Properties

@synthesize objects;

#pragma mark - Init/Dealloc

-(id)init {
	self = [super init];
	if (self) {
		objects = [NSMutableDictionary dictionary];
	}
	
	return self;
}

- (void)dealloc {
	objects = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", 
			[XmlAppCtxDictionayHandler class], @"dictionary",
			[XmlAppCtxListHandler class], @"list", nil];
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(id<IXmlApplicationContextParserHandler>)handler {
	if ([handler isKindOfClass:[XmlAppCtxObjectHandler class]]) {
		XmlAppCtxObjectHandler* object = (XmlAppCtxObjectHandler*) handler;
		if (object.objectDefinition) {
			[objects setObject:object.objectDefinition 
						forKey:object.objectDefinition.name];
		}
	}
	else if ([handler isKindOfClass:[XmlAppCtxDictionayHandler class]]) {
		XmlAppCtxDictionayHandler* dictionary = (XmlAppCtxDictionayHandler*) handler;
		if (dictionary.objectDefinition) {
			[objects setObject:dictionary.objectDefinition 
						forKey:dictionary.objectDefinition.name];
		}
	}
	else if ([handler isKindOfClass:[XmlAppCtxListHandler class]]) {
		XmlAppCtxListHandler* list = (XmlAppCtxListHandler*) handler;
		if (list.objectDefinition) {
			[objects setObject:list.objectDefinition 
						forKey:list.objectDefinition.name];
		}	
	}
	
}

@end
