//
//  XmlAppCtxDictionayHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Implementation/Support/Handlers/XmlAppCtxHandlerBase.h>

@protocol IObjectDefinition;

@interface XmlAppCtxDictionayHandler : XmlAppCtxHandlerBase {
	@private
	NSMutableDictionary* dictionary;
	id<IObjectDefinition> objectDefinition;
}

@property (nonatomic, readonly) NSMutableDictionary* dictionary;
@property (nonatomic, readonly) id<IObjectDefinition> objectDefinition;

@end
