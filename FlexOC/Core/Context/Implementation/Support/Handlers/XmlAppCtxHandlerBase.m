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

@synthesize  parent, elements, children;

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
    }
    return self;
}

- (void)dealloc {
    self.elements = nil;
	self.parent = nil;
	children = nil;
}

#pragma mark - Public methods

-(BOOL) beginHandlingElement:(NSString*) elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser*) parser {
	parser.delegate = self;
	return YES;
}

-(void) endHandlingElement:(NSString*) elementName forParser:(NSXMLParser*) parser {
	parser.delegate = self.parent;
}

-(void) willBeginHandlingElement:(NSString*) elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser*) parser withHandler:(id<IXmlApplicationContextParserHandler>) handler {
}

-(void) didEndHandlingElement:(NSString*) elementName forParser:(NSXMLParser*) parser withHandler:(id<IXmlApplicationContextParserHandler>) handler {
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	Class handlerClass = [elements objectForKey:elementName];
	if (!handlerClass) return;
	
	id<IXmlApplicationContextParserHandler> handler = [[handlerClass alloc] init];
	if (!handler) return;
	handler.parent = self;
	
	///
	[self willBeginHandlingElement:elementName 
					 withAttribute:attributeDict 
						 forParser:parser 
					   withHandler:handler];
	
	if (![handler beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser]) {
		[parser abortParsing];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[self endHandlingElement:elementName forParser:parser];
	
	[self.parent didEndHandlingElement:elementName 
							 forParser:parser 
						   withHandler:self];
}

@end