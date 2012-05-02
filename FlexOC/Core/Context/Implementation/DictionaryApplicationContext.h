//
//  DictionaryApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FlexOC/Core/Context/IApplicationContext.h>
#import <FlexOC/Core/Caching/ICache.h>

extern const NSString* DictionaryApplicationContextKeywords[];

typedef enum {
	ApplicationContextKey,
	ApplicationContextIncludes,
	ApplicationContextCircularFlag,
	ApplicationContextObjectsSection,
	ApplicationContextResourceSection,
	ObjectType,
	ObjectSingleton,
	ObjectLazy,
	ObjectProperties,
	ObjectPropertyReference,
	ObjectPropertyValue,
	ObjectPropertyNestedObject,
	ObjectPropertyNestedDictionary,	
	ObjectFactoryMethod,
	ObjectFactoryObject,
	ObjectInitSection,
	ObjectInitSelector,
	ObjectInitArguments,
	ObjectInitArgumentReference = ObjectPropertyReference,
	ObjectInitArgumentValue = ObjectPropertyValue,
} DictionaryApplicationContextKeywordIDS;

@interface DictionaryApplicationContext : NSObject<IApplicationContext> {
	@private
	NSMutableDictionary* objectsCfg;
	
	id<ICache> singletons;
	
	BOOL allowCircularDependencies;
}

-(id) initWithDictionary:(NSDictionary*) configuration;

@end
