//
//  XmlAppCtxContainerEntryHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Support/Handlers/Object/XmlAppCtxObjectArgumentHandler.h>

@interface XmlAppCtxContainerEntryHandler : XmlAppCtxObjectArgumentHandler {
	@private
	NSString* key;
}

@property (nonatomic, readonly) NSString* key;

@end
