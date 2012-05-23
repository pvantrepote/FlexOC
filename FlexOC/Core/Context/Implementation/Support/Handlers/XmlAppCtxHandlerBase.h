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
	NSMutableArray* children;
	__weak id<IXmlApplicationContextParserHandler> parent;
}

@property (nonatomic, weak) id<IXmlApplicationContextParserHandler> parent;
@property (nonatomic, readonly) NSDictionary* supportedElements;

@end