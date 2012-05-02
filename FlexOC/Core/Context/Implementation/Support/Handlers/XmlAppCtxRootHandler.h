//
//  XmlAppCtxRootHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FlexOC/Core/Context/Implementation/Support/Handlers/XmlAppCtxHandlerBase.h>

@interface XmlAppCtxRootHandler : XmlAppCtxHandlerBase {
	@private
	NSMutableDictionary* rootElement;
}

@end
