//
//  XmlAppCtxObjectInitHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Implementation/Support/Handlers/XmlAppCtxHandlerBase.h>

@protocol IObjectInitDefinition;
@protocol IObjectValueDefinition;

@interface XmlAppCtxObjectInitHandler : XmlAppCtxHandlerBase {
	@private
	id<IObjectInitDefinition> initDefinition;
}

@property (nonatomic, readonly) id<IObjectInitDefinition> initDefinition;

@end