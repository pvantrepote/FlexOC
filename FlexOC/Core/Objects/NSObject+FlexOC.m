//
//  NSObject+FlexOC.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-28.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "NSObject+FlexOC.h"

#import <FlexOC/FlexOC.h>

@implementation NSObject (FlexOC)

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
	
	if ([self respondsToSelector:@selector(flexOCObjectID)]) {
		/// Get the context
		id<IApplicationContext> appContext = [IApplicationContext sharedApplicationContext];
		if (!appContext) return self;
		
		/// Get the object definition
		id<IObjectDefinition> definition = [appContext getObjectDefinitionWithName:[((id<IAnnotations>)self) flexOCObjectID]];
		if (!definition) return self;
		
		/// TODO: Handle singleton situation
		if ([definition.type isEqualToString:NSStringFromClass([self class])]) {
			/// If the definition oject type is equal to the self type, then just configure
			[appContext configureObject:self 
							   withName:[((id<IAnnotations>)self) flexOCObjectID]];
		}
		else {
			/// Otherwise, its must be a proxy, and if not, just return self
			id<IObjectValueDefinition> target = [definition.properties objectForKey:@"target"];
			if (!target) return self;
			
			id<IObjectDefinition> concreteDefinition = nil;
			if (target.type == ObjectValueTypeObject) {
				concreteDefinition = target.value;
			}
			else if (target.type == ObjectValueTypeReference) {
				concreteDefinition = [appContext getObjectDefinitionWithName:target.value];

			}
			
			if (!concreteDefinition) return self;
			
			/// Configure self
			[appContext configureObject:self 
						 withDefinition:concreteDefinition];
			
			/// Push the instance to the TLS
			[[[NSThread currentThread] threadDictionary] setObject:self 
															forKey:concreteDefinition.name];
						
			/// Get the proxy instance
			id proxyInstance = [appContext getObjectWithName:[((id<IAnnotations>)self) flexOCObjectID]];
			
			/// Remove the instance from the TLS
			[[[NSThread currentThread] threadDictionary] removeObjectForKey:concreteDefinition.name];
			
			///
			return proxyInstance;
		}
	}
	
	return self;
}

@end
