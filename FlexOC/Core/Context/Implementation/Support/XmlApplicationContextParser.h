//
//  XmlApplicationContextParser.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IXmlApplicationContextParserHandler;
@class XmlApplicationContext;

@interface XmlApplicationContextParser : NSObject 

+(BOOL) ParseWithXMLFilepath:(NSString*) path andSetAppContext:(XmlApplicationContext*) appContext;
+(BOOL) ParseWithXMLURL:(NSURL *)url andSetAppContext:(XmlApplicationContext*) appContext;

@end
