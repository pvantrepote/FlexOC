//
//  XmlAppCtxObjectPropertyHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-24.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxHandlerBase.h"

@interface XmlAppCtxObjectPropertyHandler : XmlAppCtxHandlerBase {
	@private
	NSString* name;
}

@property (nonatomic, readonly) NSString* name;

@end