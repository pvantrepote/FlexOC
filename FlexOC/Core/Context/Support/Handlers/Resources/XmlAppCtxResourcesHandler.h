//
//  XmlAppCtxResourcesHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Support/Handlers/XmlAppCtxHandlerBase.h>

@protocol IApplicationContext;

@interface XmlAppCtxResourcesHandler : XmlAppCtxHandlerBase {
	@private
	NSMutableArray* includes;
}

@property (nonatomic, readonly) NSMutableArray* includes;

@end

@interface XmlAppCtxRcsIncludeHandler : XmlAppCtxHandlerBase {
	@private
	id<IApplicationContext> context;
}

@property (nonatomic, readonly) id<IApplicationContext> context;

@end