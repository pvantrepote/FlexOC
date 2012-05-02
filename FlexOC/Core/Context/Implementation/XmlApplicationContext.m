//
//  XmlApplicationContext.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlApplicationContext.h"

#import "XmlApplicationContextParser.h"

@implementation XmlApplicationContext

#pragma mark - Init/Dealloc

-(id) initWithXmlAtFilepath:(NSString*) filepath {
	self = [super initWithDictionary:[XmlApplicationContextParser ParseWithXMLFilepath:filepath]];
	if (self) {
		
	}
	
	return self;
}

-(id) initWithXmlAtURL:(NSURL*) url {
	self = [super initWithDictionary:[XmlApplicationContextParser ParseWithXMLURL:url]];
	if (self) {
		
	}
	
	return self;
}

#pragma mark - Public methods

@end


