//
//  XmlAppCtxListHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-29.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxHandlerBase.h"

@interface XmlAppCtxListHandler : XmlAppCtxHandlerBase {
	@private
	NSMutableArray* list;
}

@property (nonatomic, readonly) NSMutableArray* list;

@end
