//
//  LazyObjectProxy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-01.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Proxy/ObjectProxy.h>
#import <FlexOC/Core/Objects/Definition/IObjectDefinition.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@protocol IApplicationContext;

@interface LazyObjectProxy : ObjectProxy

@property (nonatomic, retain) id<IApplicationContext> context;
@property (nonatomic, retain) id<IObjectDefinition> objectDefinition;
@property (nonatomic, retain) NSString* objectName;

-(id) initWithObjectDefinition:(id<IObjectDefinition>) objectDefinition_ name:(NSString*) name_ andContext:(id<IApplicationContext>) context_;

@end
