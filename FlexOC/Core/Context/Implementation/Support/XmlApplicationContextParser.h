//
//  XmlApplicationContextParser.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IXmlApplicationContextParserHandler;

@interface XmlApplicationContextParser : NSObject {
@private
	NSMutableDictionary* configuration;

	NSMutableDictionary* context;
	NSMutableDictionary* objects;

	NSMutableDictionary* currentObject;
	NSMutableDictionary* currentInit;
	
	id<IXmlApplicationContextParserHandler> currentHandler;
}

@property (nonatomic, readonly) NSDictionary* configuration;

-(BOOL) parseWithXMLFilepath:(NSString*) path;
-(BOOL) parseWithXMLURL:(NSURL*) url;

+(NSDictionary*) ParseWithXMLFilepath:(NSString*) path;
+(NSDictionary*) ParseWithXMLURL:(NSURL*) url;

@end
