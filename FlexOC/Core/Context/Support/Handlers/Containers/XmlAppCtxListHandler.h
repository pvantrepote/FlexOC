//
//  XmlAppCtxListHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-29.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Support/Handlers/XmlAppCtxHandlerBase.h>

@protocol IObjectDefinition;

@interface XmlAppCtxListHandler : XmlAppCtxHandlerBase {
	@private
	NSMutableArray* list;
	id<IObjectDefinition> objectDefinition;
}

@property (nonatomic, readonly) NSMutableArray* list;
@property (nonatomic, readonly) id<IObjectDefinition> objectDefinition;

@end
