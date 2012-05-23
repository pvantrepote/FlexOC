//
//  ApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Context/IApplicationContext.h>
#import <FlexOC/Core/Caching/ICache.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@interface ApplicationContext : NSObject<IApplicationContext> {
	@private
	NSMutableDictionary* objectsCfg;
	BOOL allowCircularDependencies;
	id<ICache> singletons;
}

@property (nonatomic, retain) NSMutableDictionary* objects;
@property (nonatomic, assign) BOOL allowCircularDependencies;

-(void) addObject:(NSString*) objectName withDefinition:(id<IObjectDefinition>) objectDefinition;

@end
