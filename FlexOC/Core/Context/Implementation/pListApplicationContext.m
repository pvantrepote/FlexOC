//
//  pListApplicationContext.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "pListApplicationContext.h"

@implementation pListApplicationContext

#pragma mark - Init/Dealloc

-(id)initWithPListAtPath:(NSString *) path {
	NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
	if (!dictionary) {
		return nil;
	}
	
	self = [super initWithDictionary:dictionary];
	if (self) {
	}
	
	return self;
}

-(id) initWithPListAtURL:(NSURL*) url {
	NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfURL:url];
	if (!dictionary) {
		return nil;
	}
	
	self = [super initWithDictionary:dictionary];
	if (self) {
	}
	
	return self;
}

@end
