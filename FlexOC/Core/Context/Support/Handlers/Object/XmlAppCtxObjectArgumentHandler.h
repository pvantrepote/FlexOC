//
//  XmlAppCtxObjectArgumentHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Support/Handlers/XmlAppCtxHandlerBase.h>

@protocol IObjectInitDefinition;
@protocol IObjectValueDefinition;

@interface XmlAppCtxObjectArgumentHandler  : XmlAppCtxHandlerBase {
@protected
	id<IObjectValueDefinition> valueDefinition;
}

@property (nonatomic, readonly) id<IObjectValueDefinition> valueDefinition;

@end