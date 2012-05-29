//
//  XmlAppCtxObjectHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-22.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Support/Handlers/XmlAppCtxHandlerBase.h>

@protocol IObjectDefinition;

@interface XmlAppCtxObjectHandler : XmlAppCtxHandlerBase {
	@private
	id<IObjectDefinition> objectDefinition;
}

@property (nonatomic, retain) id<IObjectDefinition> objectDefinition;

@end
