//
//  DictionaryApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Context/Implementation/ApplicationContext.h>
#else
#import <FlexOC/FlexOC.h>
#endif

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

@interface DictionaryApplicationContext : ApplicationContext {
}

-(id) initWithDictionary:(NSDictionary*) configuration;

@end
