//
//  IApplicationContext.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "IApplicationContext.h"

#import "XmlApplicationContext.h"
#import "pListApplicationContext.h"

@implementation IApplicationContext

#pragma mark - Public methods

+(id<IApplicationContext>) ApplicationContextFromLocation:(NSString*) location {
	id<IApplicationContext> context = nil;
	
	NSString* extension = [location pathExtension];
	if ([extension caseInsensitiveCompare:@"xml"] == NSOrderedSame) {
		context = [[XmlApplicationContext alloc] initWithXmlAtFilepath:location];
	}
	else if ([extension caseInsensitiveCompare:@"plist"] == NSOrderedSame) {
		context = [[pListApplicationContext alloc] initWithPListAtPath:location];
	}
	
	return context;
}

+(id<IApplicationContext>) sharedApplicationContext {
	static DictionaryApplicationContext* gApplicationContext;

	if (!gApplicationContext) {
		@synchronized(self) {
			if (!gApplicationContext) {
				NSDictionary* applicationInfos = [[NSBundle mainBundle] infoDictionary];
				gApplicationContext = [[DictionaryApplicationContext alloc] initWithDictionary:applicationInfos];			
			}
		}		
	}
	
	return gApplicationContext;
}

@end