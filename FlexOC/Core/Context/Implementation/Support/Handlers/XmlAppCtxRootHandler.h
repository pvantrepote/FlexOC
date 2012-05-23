//
//  XmlAppCtxRootHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FlexOC/Core/Context/Implementation/Support/Handlers/XmlAppCtxHandlerBase.h>
@class ApplicationContext;

@interface XmlAppCtxRootHandler : XmlAppCtxHandlerBase {
	@private
	ApplicationContext* context;
}

@property (nonatomic, retain) ApplicationContext* context;

@end
