//
//  IXmlApplicationContextParserHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IXmlApplicationContextParserHandler <NSObject, NSXMLParserDelegate>

@property (nonatomic, retain) id<IXmlApplicationContextParserHandler> parent;
@property (nonatomic, readonly) NSMutableArray* children;;

-(BOOL) beginHandlingElement:(NSString*) elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser*) parser;
-(void) endHandlingElement:(NSString*) elementName forParser:(NSXMLParser*) parser;

-(void) willBeginHandlingElement:(NSString*) elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser*) parser withHandler:(id<IXmlApplicationContextParserHandler>) handler;
-(void) didEndHandlingElement:(NSString*) elementName forParser:(NSXMLParser*) parser withHandler:(id<IXmlApplicationContextParserHandler>) handler;


@end
