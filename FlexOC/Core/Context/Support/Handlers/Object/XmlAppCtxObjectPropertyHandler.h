//
//  XmlAppCtxObjectPropertyHandler.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-24.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Context/Support/Handlers/Object/XmlAppCtxObjectArgumentHandler.h>

@protocol IObjectValueDefinition;

@interface XmlAppCtxObjectPropertyHandler : XmlAppCtxObjectArgumentHandler {
	@private
	NSString* name;
}

@property (nonatomic, readonly) NSString* name;

@end