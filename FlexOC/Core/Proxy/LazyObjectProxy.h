//
//  LazyObjectProxy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-01.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Proxy/ObjectProxy.h>

@protocol IApplicationContext;

@interface LazyObjectProxy : ObjectProxy

@property (nonatomic, retain) id<IApplicationContext> context;
@property (nonatomic, retain) NSDictionary* objectDefinition;
@property (nonatomic, retain) NSString* objectName;

-(id) initWithObjectDefinition:(NSDictionary*) definition_ name:(NSString*) name_ andContext:(id<IApplicationContext>) context_;

@end
