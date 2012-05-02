//
//  XmlAppCtxHandlerBase.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxHandlerBase.h"

#import "XmlAppCtxRootHandler.h"

@interface XmlAppCtxHandlerBase ()

@property (nonatomic, retain) NSDictionary* elements;

@end

@implementation XmlAppCtxHandlerBase

#pragma mark - Properties

@synthesize  context, parent, elements, children;

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObject:[XmlAppCtxRootHandler class]
									   forKey:@"flexoccontext"];
}

-(void)setParent:(id<IXmlApplicationContextParserHandler>)parent_ {
	if (parent == parent_) return;
	
	if (parent) {
		[parent.children removeObject:self];
	}
	
	if (parent_) {
		parent = parent_;
		[parent.children addObject:self];
		
		self.context = parent_.context;
	}
	else {
		parent = nil;
	}
}

#pragma mark - Init/Dealloc

- (id)init {
    self = [super init];
    if (self) {
        self.elements = self.supportedElements;
		children = [NSMutableArray array];
		stack = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    self.elements = nil;
	self.parent = nil;
	children = nil;
	stack = nil;
}

#pragma mark - Public methods

-(BOOL) beginHandlingElement:(NSString*) elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser*) parser {
	parser.delegate = self;
	
	return YES;
}

-(void) endHandlingElement:(NSString*) elementName forParser:(NSXMLParser*) parser {
	parser.delegate = self.parent;
	
	while ([self popContext]) {}
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	Class handlerClass = [elements objectForKey:elementName];
	if (!handlerClass) return;
	
	id<IXmlApplicationContextParserHandler> handler = [[handlerClass alloc] init];
	if (!handler) return;
	
	handler.parent = self;
	if (![handler beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser]) {
		[parser abortParsing];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[self endHandlingElement:elementName forParser:parser];
}

-(void)pushNewContextForKey:(const NSString *)key {
	[self.context setObject:[NSMutableDictionary dictionary] 
							forKey:key];
	self.context = [self.context objectForKey:key];
	
	[stack addObject:self.context];
}

-(BOOL) popContext {
	if ([stack count]) {
		[stack removeLastObject];
		if ([stack count]) {
			self.context = [stack lastObject];
		}
		else {
			self.context = self.parent.context;
		}
	}
	
	return ([stack count] != 0);
}

@end