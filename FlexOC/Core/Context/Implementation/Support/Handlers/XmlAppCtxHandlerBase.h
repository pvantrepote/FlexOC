//
//  XmlAppCtxHandlerBase.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FlexOC/Core/Context/Implementation/Support/IXmlApplicationContextParserHandler.h>

@interface XmlAppCtxHandlerBase : NSObject<IXmlApplicationContextParserHandler, NSXMLParserDelegate> {
	@private
	NSDictionary* elements;
	NSMutableArray* children;
	__weak id<IXmlApplicationContextParserHandler> parent;
	
	NSMutableArray* stack;
}

@property (nonatomic, weak) id<IXmlApplicationContextParserHandler> parent;
@property (nonatomic, retain) NSMutableDictionary* context;
@property (nonatomic, readonly) NSDictionary* supportedElements;

-(void) pushNewContextForKey:(const NSString*) key;
-(BOOL) popContext;

@end