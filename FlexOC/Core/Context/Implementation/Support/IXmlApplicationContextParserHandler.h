//
//  IXmlApplicationContextParserHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IXmlApplicationContextParserHandler <NSObject, NSXMLParserDelegate>

@property (nonatomic, weak) id<IXmlApplicationContextParserHandler> parent;
@property (nonatomic, readonly) NSMutableArray* children;;
@property (nonatomic, retain) NSMutableDictionary* context;

-(BOOL) beginHandlingElement:(NSString*) elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser*) parser;
-(void) endHandlingElement:(NSString*) elementName forParser:(NSXMLParser*) parser;

@end
